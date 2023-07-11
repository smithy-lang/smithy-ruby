# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'weather'

module Weather
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:retry_strategy) { Hearth::Retry::Standard.new(max_attempts: 1) }
    let(:config) do
      Config.new(
        stub_responses: true,
        validate_input: false,
        endpoint: endpoint,
        retry_strategy: retry_strategy
      )
    end
    let(:client) { Client.new(config) }

    describe '#operation____789_bad_name' do

      describe 'NoSuchResource Errors' do
        # Does something
        #
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
      end

    end

    describe '#get_city' do

      describe 'requests' do
        # Does something
        #
        it 'WriteGetCityAssertions' do
          opts = {}
          client.get_city({
            city_id: "123"
          }, **opts)
        end
      end

      describe 'responses' do
        # Does something
        #
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
        #
        it 'stubs WriteGetCityResponseAssertions' do
          allow(Builders::GetCity).to receive(:build)
          client.stub_responses(:get_city, {
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

      describe 'NoSuchResource Errors' do
        # Does something
        #
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
      end

    end

    describe '#get_city_announcements' do

      describe 'NoSuchResource Errors' do
        # Does something
        #
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
      end

    end

    describe '#get_city_image' do

      describe 'NoSuchResource Errors' do
        # Does something
        #
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
      end

    end

    describe '#get_current_time' do

    end

    describe '#get_forecast' do

    end

    describe '#list_cities' do

      describe 'requests' do
        # Does something
        #
        it 'WriteListCitiesAssertions' do
          opts = {}
          client.list_cities({
            page_size: 50
          }, **opts)
        end
      end

    end

  end
end
