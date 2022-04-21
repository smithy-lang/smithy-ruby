# frozen_string_literal: true

module Hearth
  module Retry
    describe ClientRateLimiter do
      let(:mutex) { subject.instance_variable_get(:@mutex) }

      ######
      # Cubic Calculator tests
      #  Inspired by: https://github.com/jamesls/botocore/blob/f6bec32a13d6b45d29dc054726edd3c1cdf99b26/tests/unit/retries/test_throttling.py
      it 'sets the time window correctly from max rate' do
        subject.instance_variable_set(:@last_max_rate, 10)
        subject.send(:calculate_time_window)
        expect(subject.instance_variable_get(:@time_window))
          .to be_within(0.1).of(1.9)
      end

      it 'decreases rate by beta when throttled' do
        rate_when_throttled = 8
        new_rate = subject.send(
          :cubic_throttle, rate_when_throttled
        )
        expect(new_rate).to eq(rate_when_throttled * 0.7)
      end

      it 'should match beta decrease' do
        stub_const('Hearth::Retry::ClientRateLimiter::BETA', 0.6)
        subject.instance_variable_set(:@last_max_rate, 10)

        new_rate = subject.send(:cubic_throttle, 10)
        subject.instance_variable_set(:@last_throttle_time, 1)
        subject.send(:calculate_time_window)
        expect(new_rate).to eq(6.0)

        new_rate = subject.send(:cubic_success, 1)
        expect(new_rate).to be_within(0.1).of(6.0)
      end

      #######
      # Rate Clocker tests
      # Inspired by: https://github.com/jamesls/botocore/blob/f6bec32a13d6b45d29dc054726edd3c1cdf99b26/tests/unit/retries/test_adaptive.py#L91
      it 'updates rate if after bucket range' do
        subject.instance_variable_set(:@last_tx_rate_bucket, 0)
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(1)

        subject.send(:update_measured_rate)
        # This should be 1 * 0.8 + 0 * 0.2, or just 0.8
        expect(subject.instance_variable_get(:@measured_tx_rate))
          .to be_within(0.1).of(0.8)
      end

      it 'can measure a constant rate' do
        subject.instance_variable_set(:@last_tx_rate_bucket, 0)

        # send a constant 2 TPS
        (1..8).each do |t|
          allow(Process).to receive(:clock_gettime)
            .with(Process::CLOCK_MONOTONIC).and_return(t / 2.0)
          subject.send(:update_measured_rate)
        end

        expect(subject.instance_variable_get(:@measured_tx_rate))
          .to be_within(0.1).of(2.0)

        # if we now wait 10 seconds (0.1 TPS)
        # our rate is somewhere between 2 TPS and 0.1 TPS
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(14)
        subject.send(:update_measured_rate)
        rate = subject.instance_variable_get(:@measured_tx_rate)
        expect(rate).to be_between(0.1, 2)
      end

      #######
      # Token Bucket Tests
      # Inspired by: https://github.com/jamesls/botocore/blob/f6bec32a13d6b45d29dc054726edd3c1cdf99b26/tests/unit/retries/test_bucket.py
      it 'can acquire amount' do
        subject.instance_variable_set(:@enabled, true)
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(0)
        subject.send(:token_bucket_update_rate, 10)

        # Request tokens every second which is well below max 10 TPS fill rate
        expect(mutex).not_to receive(:sleep)
        (1..5).each do |t|
          allow(Process).to receive(:clock_gettime)
            .with(Process::CLOCK_MONOTONIC).and_return(t)
          subject.token_bucket_acquire(1)
        end
      end

      it 'waits until capacity is available to acquire a token' do
        subject.instance_variable_set(:@enabled, true)
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(0)
        subject.send(:token_bucket_update_rate, 10)
        subject.instance_variable_set(:@max_capacity, 100)

        expect(mutex).to receive(:sleep).with(10) # 100 / fill_rate = 10
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(0, 10)
        subject.token_bucket_acquire(100, wait_to_fill: true)
      end

      it 'raises CapacityNotAvailableError when it fails to acquire a token' do
        subject.instance_variable_set(:@enabled, true)
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(0)
        subject.send(:token_bucket_update_rate, 10)

        expect { subject.token_bucket_acquire(100, wait_to_fill: false) }
          .to raise_error(CapacityNotAvailableError)
      end

      it 'can retrieve at max send rate' do
        subject.instance_variable_set(:@enabled, true)
        allow(Process).to receive(:clock_gettime)
          .with(Process::CLOCK_MONOTONIC).and_return(0)
        subject.send(:token_bucket_update_rate, 10)

        # Request a new token every 100ms (10 TPS) for 2 seconds.
        expect(mutex).not_to receive(:sleep)
        (0..20).each do |t|
          allow(Process).to receive(:clock_gettime)
            .with(Process::CLOCK_MONOTONIC).and_return(1 + (0.1 * t))
          subject.token_bucket_acquire(1)
        end
      end

      it 'wont set rate below the min fill rate' do
        subject.instance_variable_set(:@enabled, true)
        subject.send(:token_bucket_update_rate, 0.1)

        expect(subject.instance_variable_get(:@fill_rate))
          .to eq(Retry::ClientRateLimiter::MIN_FILL_RATE)
      end

      it 'acquires a token only when enabled' do
        subject.instance_variable_set(:@enabled, false)
        expect(mutex).not_to receive(:sleep)
        subject.token_bucket_acquire(1)
      end

      it 'enables the token bucket on throttling errors' do
        subject.update_sending_rate(true)
        expect(subject.instance_variable_get(:@enabled)).to be(true)
      end

      # TODO: need tests on throttling: -> [measured_rate, fill_rate].min
      it 'uses a minimum rate when already enabled'

      # TODO: need test on calculate time window with cubic_success branch
      it 'does not use the token bucket on non-throttling errors' # do
      #   subject.update_sending_rate(false)
      #   expect(subject.instance_variable_get(:@enabled)).to be(false)
      # end

      context 'thread safety' do
        it 'can change max rate while blocking' do
          # This isn't a stress test - we just verify we can change the
          # rate while we acquire a token
          subject.instance_variable_set(:@enabled, true)
          # Set a rate to 0.5 (the min rate).  This means it will take
          # 2 seconds to acquire a single token
          subject.send(:token_bucket_update_rate, 0.5)

          # Start a thread to acquire a token
          test_thread = Thread.new do
            subject.token_bucket_acquire(1)
          end

          # ensure the new thread has a chance to start
          sleep(0.1)

          # Now in the main thread, update the rate to something really quick.
          # This should let us get a token back very quickly (~0.01 seconds)
          mutex.synchronize do
            subject.send(:token_bucket_update_rate, 100)
          end
          start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
          subject.token_bucket_acquire(1)
          main_thread_time =
            Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time

          test_thread.join # wait for the first thread to finish
          test_thread_time =
            Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time

          expect(main_thread_time).to be < 0.1
          expect(test_thread_time).to be > 1.0
        end

        it 'doesnt starve any threads during a stress test' do
          subject.instance_variable_set(:@enabled, true)
          subject.send(:token_bucket_update_rate, 500)

          shutdown_threads = false
          threads = []
          n_test_threads = 5
          acquisitions = Array.new(n_test_threads, 0)

          n_test_threads.times do |i|
            threads << Thread.new do
              until shutdown_threads
                subject.token_bucket_acquire(1)
                acquisitions[i] += 1
              end
            end
          end

          # run a stress test for a few seconds.
          # Increase this to stress test more locally
          sleep(3)
          shutdown_threads = true
          threads.each(&:join)

          # We can't really rely on any guarantees about evenly distributing
          # thread acquisitions. But we can sanity check that our implementation
          # isn't drastically starving a thread.
          # Check that no thread has at least one acquisition
          # mean = acquisitions.reduce(:+).to_f / acquisitions.size
          # expect(acquisitions.all? { |x| x > 0.1 * mean }).to be true
          expect(acquisitions.all? { |x| x > 0 }).to be true
        end
      end
    end
  end
end
