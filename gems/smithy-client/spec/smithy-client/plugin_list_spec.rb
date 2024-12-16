# frozen_string_literal: true

module Smithy
  module Client
    describe PluginList do
      before(:each) do
        stub_const('Plugin1', Class.new)
        stub_const('Plugin2', Class.new)
      end

      # rubocop:disable Lint/ConstantDefinitionInBlock
      class LazyPlugin
        def self.const_missing(name)
          const = Object.new
          const_set(name, const)
          const
        end
      end
      # rubocop:enable Lint/ConstantDefinitionInBlock

      subject { PluginList.new }

      describe '#initialize' do
        it 'can be constructed with a list of plugins' do
          expect(PluginList.new([Plugin1, Plugin2]).to_a).to eq([Plugin1, Plugin2])
        end

        it 'can be seeded from another plugin list' do
          subject.add(Plugin1)
          subject.add(Plugin2)
          expect(PluginList.new(subject).to_a).to eq([Plugin1, Plugin2])
        end

        it 'does not load plugins when constructing from another plugin list' do
          subject.add('Smithy::Client::LazyPlugin::CopyConstructor')
          expect(LazyPlugin.const_defined?(:CopyConstructor)).to eq(false)
          PluginList.new(subject)
          expect(LazyPlugin.const_defined?(:CopyConstructor)).to eq(false)
        end
      end

      describe '#each' do
        it 'is enumerable' do
          expect(subject).to be_kind_of(Enumerable)
        end
      end

      describe '#add' do
        it 'adds a new plugin' do
          subject.add(Plugin1)
          expect(subject.to_a).to eq([Plugin1])
        end

        it 'accepts a plugin by name (String)' do
          subject.add('String')
          expect(subject.to_a).to eq([String])
        end

        it 'accepts a plugin by name (Symbol)' do
          subject.add(:String)
          expect(subject.to_a).to eq([String])
        end

        it 'accepts a plugin object' do
          plugin = Object.new
          subject.add(plugin)
          expect(subject.to_a).to eq([plugin])
        end

        it 'only accepts one copy of each plugin' do
          plugin = Object.new
          subject.add(plugin)
          subject.add(plugin)
          expect(subject.to_a).to eq([plugin])
        end

        it 'does not require plugins when added' do
          subject.add('Smithy::Client::LazyPlugin::Add')
          expect(LazyPlugin.const_defined?(:Add)).to eq(false)
          expect(subject.to_a).to eq([LazyPlugin::Add])
          expect(LazyPlugin.const_defined?(:Add)).to eq(true)
        end
      end

      describe '#remove' do
        it 'removes the plugin' do
          subject.add(Plugin1)
          subject.add(Plugin2)
          subject.remove(Plugin1)
          expect(subject.to_a).to eq([Plugin2])
        end

        it 'can remove a plugin added by name' do
          subject.add(:String)
          subject.remove(String)
          expect(subject.to_a).to eq([])
        end
      end

      describe '#set' do
        it 'replaces the existing list of plugins' do
          subject.add(Plugin1)
          subject.set([Plugin2])
          expect(subject.to_a).to eq([Plugin2])
        end
      end

      context 'thread safety' do
        let(:mutex_class) do
          Class.new do
            def initialize
              @was_locked = false
            end

            attr_reader :was_locked

            def synchronize
              @was_locked = true
              yield
            end
          end
        end
        let(:mutex) { mutex_class.new }

        before do
          expect(Mutex).to receive(:new).and_return(mutex)
        end

        it 'locks the mutex when adding a plugin' do
          expect(mutex.was_locked).to eq(false)
          subject.add(Plugin1)
          expect(mutex.was_locked).to eq(true)
        end

        it 'locks the mutex when removing a plugin' do
          expect(mutex.was_locked).to eq(false)
          subject.remove(Plugin1)
          expect(mutex.was_locked).to eq(true)
        end

        it 'locks the mutex when enumerating plugins' do
          expect(mutex.was_locked).to eq(false)
          subject.each { |_plugin| } # empty
          expect(mutex.was_locked).to eq(true)
        end
      end
    end
  end
end
