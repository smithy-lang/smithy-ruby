# frozen_string_literal: true

module Hearth
  describe PluginList do
    let(:plugin) do
      proc { |_config| }
    end

    it 'is enumerable' do
      expect(PluginList).to include(Enumerable)
      expect(PluginList.new).to respond_to(:each)
    end

    describe '#initialize' do
      it 'raises when given a non enumerable' do
        expect do
          PluginList.new('bad_arg')
        end.to raise_error(ArgumentError)
      end

      it 'can be initialized with a list of plugins' do
        plugin_list = PluginList.new([plugin])
        expect(plugin_list.to_a).to eq([plugin])
      end

      it 'can be initialized from a PluginList' do
        plugin_list = PluginList.new(PluginList.new([plugin]))
        expect(plugin_list.to_a).to eq([plugin])
      end
    end

    describe '#add' do
      let(:plugin_list) { PluginList.new }

      it 'adds the plugin' do
        plugin_list.add(plugin)
        expect(plugin_list.to_a).to eq([plugin])
      end

      context 'proc with incorrect number of arguments' do
        let(:plugin) do
          proc {}
        end

        it 'raises an argument error' do
          expect do
            plugin_list.add(plugin)
          end.to raise_error(ArgumentError)
        end
      end

      context 'non-callable object' do
        let(:plugin) do
          Class.new.new
        end

        it 'raises an argument error' do
          expect do
            plugin_list.add(plugin)
          end.to raise_error(ArgumentError)
        end
      end

      context 'callable object with incorrect args' do
        let(:plugin) do
          Class.new do
            def call; end
          end.new
        end

        it 'raises an argument error' do
          expect do
            plugin_list.add(plugin)
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
