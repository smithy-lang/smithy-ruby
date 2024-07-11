# frozen_string_literal: true

describe Hearth do
  it 'has a VERSION' do
    expect(Hearth::VERSION).to be_a(String)
  end

  describe '.config=' do
    it 'raises when not given a hash' do
      expect { Hearth.config = nil }.to raise_error(ArgumentError, /hash/)
    end

    it 'sets the config' do
      Hearth.config = { foo: 'bar' }
      expect(Hearth.config[:foo]).to eq('bar')
    end
  end
end
