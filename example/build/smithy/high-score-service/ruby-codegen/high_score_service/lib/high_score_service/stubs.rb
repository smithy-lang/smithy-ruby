# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
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
      def self.build(params, context:)
        Params::CreateHighScoreOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::CreateHighScoreOutput.validate!(output, context: context)
      end

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
      def self.build(params, context:)
        Params::DeleteHighScoreOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DeleteHighScoreOutput.validate!(output, context: context)
      end

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
      def self.build(params, context:)
        Params::GetHighScoreOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::GetHighScoreOutput.validate!(output, context: context)
      end

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
      def self.build(params, context:)
        Params::ListHighScoresOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ListHighScoresOutput.validate!(output, context: context)
      end

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
      def self.build(params, context:)
        Params::UnprocessableEntityError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::UnprocessableEntityError.validate!(output, context: context)
      end

      def self.default(visited = [])
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
      def self.build(params, context:)
        Params::UpdateHighScoreOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::UpdateHighScoreOutput.validate!(output, context: context)
      end

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
