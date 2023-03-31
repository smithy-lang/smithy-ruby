# frozen_string_literal: true

module Aws
  module Crt
    module Checksums
    end
  end
end

module Hearth
  module Checksums
    describe CRC32C do
      context 'crt is not available' do
        before { allow(Hearth).to receive(:use_crt?).and_return(false) }

        it 'raises an ArgumentError' do
          expect { CRC32C.new }.to raise_error(ArgumentError)
        end
      end

      context 'crt is available' do
        before { allow(Hearth).to receive(:use_crt?).and_return(true) }
        let(:crc32c) { double }

        it 'initializes Digest32 with the crt method' do
          expect(Aws::Crt::Checksums)
            .to receive(:method).with(:crc32c).and_return(crc32c)
          expect_any_instance_of(Digest32).to receive(:initialize).with(crc32c)
          CRC32C.new
        end
      end
    end
  end
end
