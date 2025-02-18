# frozen_string_literal: true

module Smithy
  describe Model do
    describe '#shape' do
      let(:model) { { 'shapes' => { 'smithy.ruby.tests#Shape' => { 'type' => 'string' } } } }

      it 'returns a shape' do
        shape = Model.shape(model, 'smithy.ruby.tests#Shape')
        expect(shape).to be_a(Hash)
        expect(shape['type']).to eq('string')
      end

      it 'returns prelude shapes if not present in the model' do
        shape = Model.shape(model, 'smithy.api#Unit')
        expect(shape).to be_a(Hash)
        expect(shape['type']).to eq('structure')
      end

      it 'raises an error when the shape is not found' do
        expect { Model.shape(model, 'smithy.ruby.tests#NoSuchShape') }.to raise_error(ArgumentError)
      end

      context 'mixins' do
        # Tests taken from https://smithy.io/2.0/spec/mixins.html#mixins
        let(:fixture) do
          JSON.load_file(File.expand_path("../fixtures/mixins/#{fixture_name}/model.json", __dir__.to_s))
        end

        context 'vanilla' do
          let(:fixture_name) { 'vanilla' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#UserDetails')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['alias'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserDetails']['members']['alias'])
            expect(shape['members']['id'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserIdentifiersMixin']['members']['id'])
          end
        end

        context 'multiple' do
          let(:fixture_name) { 'multiple' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#UserDetails')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['alias'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserDetails']['members']['alias'])
            expect(shape['members']['id'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserIdentifiersMixin']['members']['id'])
            expect(shape['members']['firstAccess'])
              .to eq(fixture['shapes']['smithy.ruby.tests#AccessDetailsMixin']['members']['firstAccess'])
            expect(shape['members']['lastAccess'])
              .to eq(fixture['shapes']['smithy.ruby.tests#AccessDetailsMixin']['members']['lastAccess'])
          end
        end

        context 'composed' do
          let(:fixture_name) { 'composed' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#C')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['a']).to eq(fixture['shapes']['smithy.ruby.tests#MixinA']['members']['a'])
            expect(shape['members']['b']).to eq(fixture['shapes']['smithy.ruby.tests#MixinB']['members']['b'])
            expect(shape['members']['c']).to eq(fixture['shapes']['smithy.ruby.tests#C']['members']['c'])
          end
        end

        context 'type agnostic' do
          let(:fixture_name) { 'type-agnostic' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#Username')
            expect(shape).to_not have_key('mixins')
            expect(shape['traits']['smithy.api#length'])
              .to eq(fixture['shapes']['smithy.ruby.tests#Username']['traits']['smithy.api#length'])
            expect(shape['traits']['smithy.api#pattern'])
              .to eq(fixture['shapes']['smithy.ruby.tests#AlphaNumericMixin']['traits']['smithy.api#pattern'])
          end
        end

        context 'trait inheritance' do
          let(:fixture_name) { 'trait-inheritance' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#UserSummary')
            expect(shape).to_not have_key('mixins')
            expect(shape['traits']['smithy.api#documentation'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserInfoMixin']['traits']['smithy.api#documentation'])
            expect(shape['traits']['smithy.api#tags'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserInfoMixin']['traits']['smithy.api#tags'])
          end
        end

        context 'trait override' do
          let(:fixture_name) { 'trait-override' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#UserSummary')
            expect(shape).to_not have_key('mixins')
            expect(shape['traits']['smithy.api#documentation'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserSummary']['traits']['smithy.api#documentation'])
            expect(shape['traits']['smithy.api#tags'])
              .to eq(fixture['shapes']['smithy.ruby.tests#UserSummary']['traits']['smithy.api#tags'])
          end
        end

        context 'trait order' do
          let(:fixture_name) { 'trait-order' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#StructD')
            expect(shape).to_not have_key('mixins')
            expect(shape['traits']['smithy.api#documentation'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructD']['traits']['smithy.api#documentation'])
            expect(shape['traits']['fourTrait'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructD']['traits']['fourTrait'])
            expect(shape['traits']['threeTrait'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructC']['traits']['threeTrait'])
            expect(shape['traits']['foo'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructB']['traits']['foo'])
            expect(shape['traits']['twoTrait'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructB']['traits']['twoTrait'])
            expect(shape['traits']['oneTrait'])
              .to eq(fixture['shapes']['smithy.ruby.tests#StructA']['traits']['oneTrait'])
          end

          it 'preserves trait order' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#StructD')
            expected = %w[
              smithy.api#documentation
              smithy.ruby.tests#fourTrait
              smithy.ruby.tests#threeTrait
              smithy.ruby.tests#foo
              smithy.ruby.tests#twoTrait
              smithy.ruby.tests#oneTrait
            ]
            expect(shape['traits'].keys).to eq(expected)
          end
        end

        context 'local traits' do
          let(:fixture_name) { 'local-traits' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#PublicShape')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['foo'])
              .to eq(fixture['shapes']['smithy.ruby.tests#PrivateMixin']['members']['foo'])
            expect(shape['traits']).to be_nil
          end
        end

        context 'apply' do
          let(:fixture_name) { 'apply' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#MyStruct')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['mixinMember']['traits']['smithy.api#documentation'])
              .to eq(fixture['shapes']['smithy.ruby.tests#MyStruct$mixinMember']['traits']['smithy.api#documentation'])
          end
        end

        context 'redefine' do
          let(:fixture_name) { 'redefine' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#Valid')
            expect(shape).to_not have_key('mixins')
            expect(shape['members']['a']).to eq(fixture['shapes']['smithy.ruby.tests#A2']['members']['a'])
          end
        end

        context 'member order' do
          let(:fixture_name) { 'member-order' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#ListSomethingInput')
            expect(shape).to_not have_key('mixins')
            expect(shape['members'].keys).to eq(%w[nextToken pageSize nameFilter sizeFilter])
          end
        end

        context 'service mixins' do
          let(:fixture_name) { 'services' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#C')
            expect(shape).to_not have_key('mixins')
            expect(shape['version']).to eq(fixture['shapes']['smithy.ruby.tests#C']['version'])
            renames = [
              { 'smithy.ruby.tests#OperationAInput' => 'OperationARequest' },
              { 'smithy.ruby.tests#OperationAOutput' => 'OperationAResponse' },
              { 'smithy.ruby.tests#OperationBInput' => 'OperationBRequest' },
            ]
            expect(shape['rename']).to eq(renames)
            operations = [
              { 'target' => 'smithy.ruby.tests#OperationA' },
              { 'target' => 'smithy.ruby.tests#OperationB' },
              { 'target' => 'smithy.ruby.tests#OperationC' },
            ]
            expect(shape['operations']).to eq(operations)
          end
        end

        context 'resource mixins' do
          let(:fixture_name) { 'resources' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#MixedResource')
            expect(shape).to_not have_key('mixins')
            expect(shape['traits']['smithy.api#internal'])
              .to eq(fixture['shapes']['smithy.ruby.tests#MixinResource']['traits']['smithy.api#internal'])
          end
        end

        context 'operation mixins' do
          let(:fixture_name) { 'operations' }

          it 'resolves mixins' do
            shape = Model.shape(fixture, 'smithy.ruby.tests#GetUsername')
            expect(shape).to_not have_key('mixins')
            errors = [
              { 'target' => 'smithy.ruby.tests#ValidationError' },
              { 'target' => 'smithy.ruby.tests#NotFoundError' }
            ]
            expect(shape['errors']).to eq(errors)
          end
        end
      end
    end
  end
end
