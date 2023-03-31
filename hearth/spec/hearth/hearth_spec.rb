# frozen_string_literal: true

describe Hearth do
  describe '.use_crt?' do
    before { Hearth.class_variable_set(:@@use_crt, nil) }

    it 'is true when aws-crt is available' do
      expect(Hearth).to receive(:require).with('aws-crt').and_return(true)
      expect(Hearth.use_crt?).to be_truthy
    end

    it 'is false when aws-crt is not available' do
      expect(Hearth).to receive(:require).with('aws-crt').and_raise(LoadError)
      expect(Hearth.use_crt?).to be_falsey
    end

    it 'memoizes its status' do
      expect(Hearth).to receive(:require).once.with('aws-crt')
                                         .and_raise(LoadError)
      Hearth.use_crt?
      # second call should not call require again
      Hearth.use_crt?
    end
  end
end
