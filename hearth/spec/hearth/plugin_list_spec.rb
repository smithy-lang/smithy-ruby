# frozen_string_literal: true

module Hearth
  describe PluginList do
    describe '#initialize' do
      it 'raises when given a non enumerable' do
        expect do
          PluginList.new('bad_arg')
        end.to raise_error(ArgumentError)
      end
    end

    describe '#add' do
      let(:plugin_list) { PluginList.new }

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
    end
  end
end
