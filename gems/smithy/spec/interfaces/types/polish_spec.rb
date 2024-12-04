# frozen_string_literal: true

describe 'Types: Polishing' do
  polish = Class.new(Smithy::Polish) do
    def polish(artifact)
      file, _content = artifact.find { |file, _content| file.include?('/types.rb') }
      inject_into_module(file, 'Types') do
        "    Polish = Struct.new(keyword_init: true)\n"
      end
    end
  end

  before(:all) do
    @tmpdir = SpecHelper.generate(['Weather'], :types)
  end

  after(:all) do
    SpecHelper.cleanup(['Weather'], @tmpdir)
  end

  it 'loads the polish' do
    expect(Smithy::Polish.descendants).to include(polish)
  end

  it 'includes Thor::Actions' do
    expect(polish.ancestors).to include(Thor::Actions)
  end

  it 'can manipulate files' do
    polish = Weather::Types::Polish.new
    expect(polish).to be_a(Struct)
  end
end
