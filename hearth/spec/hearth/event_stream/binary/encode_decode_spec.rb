# frozen_string_literal: true

module Hearth
  module EventStream
    module Binary
      describe 'Encode/Decode' do
        def build_message(path)
          data = JSON.parse(File.read(path))
          Hearth::EventStream::Message.new(
            headers: build_headers(data['headers']),
            payload: StringIO.new(Base64.decode64(data['payload']))
          )
        end

        def build_headers(headers)
          headers.each_with_object({}) do |ctx, hash|
            value = ctx['value']
            value = Base64.decode64(ctx['value']) if ctx['value'].is_a? String
            hash[ctx['name']] = Hearth::EventStream::HeaderValue.new(
              value: value,
              type: TYPES[ctx['type']]
            )
          end
        end

        Dir.glob(File.expand_path('fixtures/decoded/positive/*', __dir__))
           .each do |decode_path|
          suit_name = File.basename(decode_path)
          encoded_path = File.join(
            File.expand_path('fixtures/encoded/positive', __dir__), suit_name
          )

          next unless File.exist?(encoded_path)

          context suit_name do
            let(:message) { build_message(decode_path) }
            let(:encoded_bytes) { File.read(encoded_path, mode: 'rb') }

            it 'encodes correctly' do
              encoded = MessageEncoder.new.encode(message)
              expect(encoded).to eq(encoded_bytes)
            end

            it 'decodes correctly' do
              decoded, eof = MessageDecoder.new.decode(encoded_bytes)
              expect(eof).to be_truthy
              expect(decoded.payload.read).to eq(message.payload.read)
              expect(decoded.headers.size).to eq(message.headers.size)
              expect(decoded.headers.keys).to eq(message.headers.keys)
              decoded.headers.each do |k, v|
                expect(v.value).to eq(message.headers[k].value)
                expect(v.type).to eq(message.headers[k].type)
              end
            end
          end
        end

        # TODO: Negative tests
      end
    end
  end
end
