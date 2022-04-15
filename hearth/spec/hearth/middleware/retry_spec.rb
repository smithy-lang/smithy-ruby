# frozen_string_literal: true
#
# module Hearth
#   module Middleware
#     describe Retry do
#       let(:app) { double('app', call: output) }
#       let(:max_attempts) { 4 }
#       let(:max_delay) { 10 }
#
#       subject do
#         Retry.new(
#           app,
#           max_attempts: max_attempts,
#           max_delay: max_delay
#         )
#       end
#
#       describe '#call' do
#         let(:input) { double('Type::OperationInput') }
#         let(:output) { double('output', error: error) }
#         let(:error) { nil }
#         let(:request) { Hearth::HTTP::Request.new }
#         let(:response) { Hearth::HTTP::Response.new }
#         let(:context) do
#           Hearth::Context.new(
#             request: request,
#             response: response
#           )
#         end
#
#         it 'calls the next middleware' do
#           expect(app).to receive(:call)
#             .with(input, context).and_return(output)
#
#           subject.call(input, context)
#         end
#
#         context 'middleware raises NetworkingError' do
#           let(:error) { Hearth::HTTP::NetworkingError.new(StandardError.new) }
#
#           it 'retries with exponential backoff and jitter' do
#             expect(app).to receive(:call).with(
#               input, context
#             ).and_raise(error).exactly(4).times
#             allow(Kernel).to receive(:rand).and_return(1)
#             expect(Kernel).to receive(:sleep).with(1)
#             expect(Kernel).to receive(:sleep).with(2)
#             expect(Kernel).to receive(:sleep).with(4)
#
#             expect do
#               subject.call(input, context)
#             end.to raise_error(error)
#           end
#
#           it 'retries up to max_attempts times' do
#             expect(app).to receive(:call).with(
#               input, context
#             ).and_raise(error).exactly(4).times
#             allow(Kernel).to receive(:sleep)
#
#             expect do
#               subject.call(input, context)
#             end.to raise_error(error)
#           end
#
#           context 'max_delay' do
#             let(:max_delay) { 1 }
#
#             it 'backoff is bounded by max_delay' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_raise(error).exactly(4).times
#               allow(Kernel).to receive(:rand).and_return(1)
#               expect(Kernel).to receive(:sleep).with(1).exactly(3).times
#
#               expect do
#                 subject.call(input, context)
#               end.to raise_error(error)
#             end
#           end
#         end
#
#         context 'middleware returns output with ApiError' do
#           let(:error) do
#             Hearth::ApiError.new(
#               error_code: 'error_code',
#               metadata: {}
#             )
#           end
#
#           context 'error is not retryable' do
#             it 'returns output' do
#               expect(app).to receive(:call)
#                 .with(input, context).and_return(output)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#           end
#
#           context 'error is retryable' do
#             before do
#               allow(error).to receive(:retryable?).and_return(true)
#             end
#
#             it 'retries up to max_attempts times' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_return(output).exactly(4).times
#               allow(Kernel).to receive(:sleep)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#
#             it 'retries with exponential backoff and jitter' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_return(output).exactly(4).times
#               allow(Kernel).to receive(:rand).and_return(1)
#               expect(Kernel).to receive(:sleep).with(1)
#               expect(Kernel).to receive(:sleep).with(2)
#               expect(Kernel).to receive(:sleep).with(4)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#
#             context 'max_delay' do
#               let(:max_delay) { 1 }
#
#               it 'backoff is bounded by max_delay' do
#                 expect(app).to receive(:call).with(
#                   input, context
#                 ).and_return(output).exactly(4).times
#                 allow(Kernel).to receive(:rand).and_return(1)
#                 expect(Kernel).to receive(:sleep).with(1).exactly(3).times
#
#                 resp = subject.call(input, context)
#                 expect(resp).to eq(output)
#               end
#             end
#           end
#         end
#       end
#     end
#   end
# end
