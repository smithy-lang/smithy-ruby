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
    let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }

    describe '#operation____789_bad_name' do

      describe 'NoSuchResource Errors' do
        # Does something
        #
        it 'WriteNoSuchResourceAssertions' do
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 404
            response.body = StringIO.new('{
                "resourceType": "City",
                "message": "Your custom message"
            }')
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.__789_bad_name({}, middleware: middleware)
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
          middleware = Seahorse::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/cities/123')
            expect(request.body.read).to eq('')
            Seahorse::Output.new
          end
          client.get_city({
            city_id: "123"
          }, middleware: middleware)
        end
      end

      describe 'responses' do
        # Does something
        #
        it 'WriteGetCityResponseAssertions' do
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.body = StringIO.new('{
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
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          output = client.get_city({}, middleware: middleware)
          expect(output.to_h).to eq({
            member_name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              member_name: "Seattle",
              number: "One",
              case: "Upper"
            }
          })
        end
      end
      describe 'response stubs' do
        # Does something
        #
        it 'stubs WriteGetCityResponseAssertions' do
          middleware = Seahorse::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:get_city, {
            member_name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              member_name: "Seattle",
              number: "One",
              case: "Upper"
            }
          })
          output = client.get_city({}, middleware: middleware)
          expect(output.to_h).to eq({
            member_name: "Seattle",
            coordinates: {
              latitude: 12.34,
              longitude: -56.78
            },
            city: {
              city_id: "123",
              member_name: "Seattle",
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
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 404
            response.body = StringIO.new('{
                "resourceType": "City",
                "message": "Your custom message"
            }')
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.get_city({}, middleware: middleware)
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
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 404
            response.body = StringIO.new('{
                "resourceType": "City",
                "message": "Your custom message"
            }')
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.get_city_announcements({}, middleware: middleware)
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
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 404
            response.body = StringIO.new('{
                "resourceType": "City",
                "message": "Your custom message"
            }')
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.get_city_image({}, middleware: middleware)
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
          middleware = Seahorse::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/cities')
            expected_query = CGI.parse(['pageSize=50'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            forbid_query = ['nextToken']
            actual_query = CGI.parse(request_uri.query)
            forbid_query.each do |query|
              expect(actual_query.key?(query)).to be false
            end
            expect(request.body.read).to eq('')
            Seahorse::Output.new
          end
          client.list_cities({
            page_size: 50
          }, middleware: middleware)
        end
      end

    end
  end
end
