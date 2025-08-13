# frozen_string_literal: true

RSpec.shared_examples 'version' do |context|
  context 'VERSION file' do
    include_context context, 'Weather'

    let(:gem_name) do
      context.include?('schema') ? 'weather-schema' : 'weather'
    end

    it 'should have a VERSION file' do
      expect(File).to exist(File.join(@plan.destination_root, 'VERSION'))
    end

    it 'does not overwrite an existing VERSION file' do
      version_file = File.join(@plan.destination_root, 'VERSION')
      expect(File.read(version_file)).to eq('0.1.0')
      File.write(version_file, '1.2.3')
      SpecHelper.generate_gem('Weather', @plan.type, destination_root: @plan.destination_root)
      expect(File.read(version_file)).to eq('1.2.3')
    end
  end
end
