# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'cgi'

require 'weather'

module Weather
  describe Client do
    let(:config) do
      Config.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    let(:client) { Client.new(config) }

    describe '#operation____789_bad_name' do

      describe 'NoSuchResource error' do

        # Does something
        it 'WriteNoSuchResourceAssertions' do
          response = Hearth::HTTP::Response.new
          response.status = 404
          response.body.write('{
              "resourceType": "City",
              "message": "Your custom message"
          }')
          response.body.rewind
          client.stub_responses(:operation____789_bad_name, response)
          allow(Builders::Operation____789BadName).to receive(:build)
          begin
            client.__789_bad_name({})
          rescue Errors::NoSuchResource => e
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end

        # Does something
        it 'stubs WriteNoSuchResourceAssertions' do
          client.stub_responses(:__789_bad_name, error: { class: Errors::NoSuchResource, data: {
            resource_type: "City",
            message: "Your custom message"
          } })
          allow(Builders::Operation____789BadName).to receive(:build)
          begin
            client.__789_bad_name({})
          rescue Errors::NoSuchResource => e
            expect(e.http_status).to eq(404)
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end
      end

    end

    describe '#get_city' do

      describe 'requests' do

        # Does something
        it 'WriteGetCityAssertions' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/cities/123')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.get_city({
            city_id: "123"
          }, **opts)
        end

      end

      describe 'responses' do

        # Does something
        it 'WriteGetCityResponseAssertions' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('{
              "name": "Seattle",
              "coordinates": {
                  "latitude": 12.34,
                  "longitude": -56.78
              },
              "city": {
                  "cityId": "123",
                  "name": "Seattle",
                  "number": "One",
                  "case": "Upper"
              }
          }')
          response.body.rewind
          client.stub_responses(:get_city, response)
          allow(Builders::GetCity).to receive(:build)
          output = client.get_city({})
          expect(output.data.to_h).to eq({
            name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              name: "Seattle",
              number: "One",
              case: "Upper"
            }
          })
        end

      end

      describe 'stubs' do

        # Does something
        it 'stubs WriteGetCityResponseAssertions' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::GetCity).to receive(:build)
          client.stub_responses(:get_city, data: {
            name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              name: "Seattle",
              number: "One",
              case: "Upper"
            }
          })
          output = client.get_city({}, interceptors: [interceptor])
          expect(output.data.to_h).to eq({
            name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              name: "Seattle",
              number: "One",
              case: "Upper"
            }
          })
        end

      end

      describe 'NoSuchResource error' do

        # Does something
        it 'WriteNoSuchResourceAssertions' do
          response = Hearth::HTTP::Response.new
          response.status = 404
          response.body.write('{
              "resourceType": "City",
              "message": "Your custom message"
          }')
          response.body.rewind
          client.stub_responses(:get_city, response)
          allow(Builders::GetCity).to receive(:build)
          begin
            client.get_city({})
          rescue Errors::NoSuchResource => e
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end

        # Does something
        it 'stubs WriteNoSuchResourceAssertions' do
          client.stub_responses(:get_city, error: { class: Errors::NoSuchResource, data: {
            resource_type: "City",
            message: "Your custom message"
          } })
          allow(Builders::GetCity).to receive(:build)
          begin
            client.get_city({})
          rescue Errors::NoSuchResource => e
            expect(e.http_status).to eq(404)
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end
      end

    end

    describe '#get_city_announcements' do

      describe 'NoSuchResource error' do

        # Does something
        it 'WriteNoSuchResourceAssertions' do
          response = Hearth::HTTP::Response.new
          response.status = 404
          response.body.write('{
              "resourceType": "City",
              "message": "Your custom message"
          }')
          response.body.rewind
          client.stub_responses(:get_city_announcements, response)
          allow(Builders::GetCityAnnouncements).to receive(:build)
          begin
            client.get_city_announcements({})
          rescue Errors::NoSuchResource => e
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end

        # Does something
        it 'stubs WriteNoSuchResourceAssertions' do
          client.stub_responses(:get_city_announcements, error: { class: Errors::NoSuchResource, data: {
            resource_type: "City",
            message: "Your custom message"
          } })
          allow(Builders::GetCityAnnouncements).to receive(:build)
          begin
            client.get_city_announcements({})
          rescue Errors::NoSuchResource => e
            expect(e.http_status).to eq(404)
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end
      end

    end

    describe '#get_city_image' do

      describe 'NoSuchResource error' do

        # Does something
        it 'WriteNoSuchResourceAssertions' do
          response = Hearth::HTTP::Response.new
          response.status = 404
          response.body.write('{
              "resourceType": "City",
              "message": "Your custom message"
          }')
          response.body.rewind
          client.stub_responses(:get_city_image, response)
          allow(Builders::GetCityImage).to receive(:build)
          begin
            client.get_city_image({})
          rescue Errors::NoSuchResource => e
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end

        # Does something
        it 'stubs WriteNoSuchResourceAssertions' do
          client.stub_responses(:get_city_image, error: { class: Errors::NoSuchResource, data: {
            resource_type: "City",
            message: "Your custom message"
          } })
          allow(Builders::GetCityImage).to receive(:build)
          begin
            client.get_city_image({})
          rescue Errors::NoSuchResource => e
            expect(e.http_status).to eq(404)
            expect(e.data.to_h).to eq({
              resource_type: "City",
              message: "Your custom message"
            })
          end
        end
      end

    end

    describe '#get_current_time' do

    end

    describe '#get_forecast' do

    end

    describe '#list_cities' do

      describe 'requests' do

        # Does something
        it 'WriteListCitiesAssertions' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/cities')
            expected_query = ::CGI.parse(['pageSize=50'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            forbid_query = ['nextToken']
            actual_query = ::CGI.parse(request.uri.query)
            forbid_query.each do |query|
              expect(actual_query.key?(query)).to be false
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.list_cities({
            page_size: 50
          }, **opts)
        end

      end

    end

  end
end
