# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Stubs

    class AttributeErrors
      def self.default(visited = [])
        return nil if visited.include?('AttributeErrors')
        visited = visited + ['AttributeErrors']
        {
          key: ErrorMessages.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::ErrorMessages.stub(value) unless value.nil?
        end
        data
      end
    end

    class CreateHighScore
      TYPES_CLASS = Types::CreateHighScoreOutput
      PARAMS_CLASS = Params::CreateHighScoreOutput

      def self.default(visited = [])
        {
          high_score: HighScoreAttributes.default(visited),
          location: 'location',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 201
        http_resp.headers['Location'] = stub[:location] unless stub[:location].nil? || stub[:location].empty?
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class DeleteHighScore
      TYPES_CLASS = Types::DeleteHighScoreOutput
      PARAMS_CLASS = Params::DeleteHighScoreOutput

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ErrorMessages
      def self.default(visited = [])
        return nil if visited.include?('ErrorMessages')
        visited = visited + ['ErrorMessages']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class GetHighScore
      TYPES_CLASS = Types::GetHighScoreOutput
      PARAMS_CLASS = Params::GetHighScoreOutput

      def self.default(visited = [])
        {
          high_score: HighScoreAttributes.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class HighScoreAttributes
      def self.default(visited = [])
        return nil if visited.include?('HighScoreAttributes')
        visited = visited + ['HighScoreAttributes']
        {
          id: 'id',
          game: 'game',
          score: 1,
          created_at: Time.now,
          updated_at: Time.now,
        }
      end

      def self.stub(stub)
        stub ||= Types::HighScoreAttributes.new
        data = {}
        data[:id] = stub[:id] unless stub[:id].nil?
        data[:game] = stub[:game] unless stub[:game].nil?
        data[:score] = stub[:score] unless stub[:score].nil?
        data[:created_at] = Hearth::TimeHelper.to_date_time(stub[:created_at]) unless stub[:created_at].nil?
        data[:updated_at] = Hearth::TimeHelper.to_date_time(stub[:updated_at]) unless stub[:updated_at].nil?
        data
      end
    end

    class HighScores
      def self.default(visited = [])
        return nil if visited.include?('HighScores')
        visited = visited + ['HighScores']
        [
          HighScoreAttributes.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::HighScoreAttributes.stub(element) unless element.nil?
        end
        data
      end
    end

    class ListHighScores
      TYPES_CLASS = Types::ListHighScoresOutput
      PARAMS_CLASS = Params::ListHighScoresOutput

      def self.default(visited = [])
        {
          high_scores: HighScores.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScores.stub(stub[:high_scores]) unless stub[:high_scores].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class UnprocessableEntityError
      ERROR_CLASS = Errors::UnprocessableEntityError
      PARAMS_CLASS = Params::UnprocessableEntityError

      def self.default(visited = [])
        return nil if visited.include?('UnprocessableEntityError')
        visited = visited + ['UnprocessableEntityError']
        {
          errors: AttributeErrors.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 422
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::AttributeErrors.stub(stub[:errors]) unless stub[:errors].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class UpdateHighScore
      TYPES_CLASS = Types::UpdateHighScoreOutput
      PARAMS_CLASS = Params::UpdateHighScoreOutput

      def self.default(visited = [])
        {
          high_score: HighScoreAttributes.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end
  end
end
