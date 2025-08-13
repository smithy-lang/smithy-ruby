# frozen_string_literal: true

RSpec.shared_examples 'changelog_md' do |context|
  context 'CHANGELOG.md file' do
    include_context context, 'Weather'

    let(:gem_name) do
      context.include?('schema') ? 'weather-schema' : 'weather'
    end

    it 'should have a CHANGELOG.md file' do
      expect(File).to exist(File.join(@plan.destination_root, 'CHANGELOG.md'))
    end

    it 'does not overwrite an existing CHANGELOG.md file' do
      changelog = <<~MARKDOWN
        Unreleased Changes
        ------------------

        0.1.0 (1970-01-01)
        ------------------

        * Feature - New version
      MARKDOWN
      changelog_file = File.join(@plan.destination_root, 'CHANGELOG.md')
      expect(File.read(changelog_file)).to_not include(changelog)
      File.write(changelog_file, changelog)
      SpecHelper.generate_gem('Weather', @plan.type, destination_root: @plan.destination_root)
      expect(File.read(changelog_file)).to include(changelog)
    end
  end
end
