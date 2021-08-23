module SampleService
  # @api private
  module Stubs

    class HighScoreAttributes
      def self.default
        {
          id: 'id',
          game: 'game',
          score: 0,
          created_at: Time.now,
          updated_at: Time.now,
        }
      end

      def self.stub(stub: {})
        data = {}
        data[:id] = stub[:id]
        data[:game] = stub[:game]
        data[:score] = stub[:score]
        data[:created_at] = stub[:created_at]
        data[:updated_at] = stub[:updated_at]
        data
      end
    end

    class GetHighScore
      def self.default
        {
          high_score: HighScoreAttributes.default
        }
      end

      def self.stub(http_resp, stub: nil)
        data = HighScoreAttributes.stub(stub: stub[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class CreateHighScore
      def self.default
        {
          high_score: HighScoreAttributes.default
        }
      end

      def self.stub(http_resp, stub: nil)
        data = HighScoreAttributes.stub(stub: stub[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 201
      end
    end

    class UpdateHighScore
      def self.default
        {
          high_score: HighScoreAttributes.default
        }
      end

      def self.stub(http_resp, stub: nil)
        data = HighScoreAttributes.stub(stub: stub[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class DeleteHighScore
      def self.default
        {}
      end

      def self.stub(http_resp, stub: nil)
        data = {}
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class ListHighScores
      def self.default
        {
          high_scores: HighScores.default
        }
      end

      def self.stub(http_resp, stub: nil)
        data = HighScores.stub(stub[:high_scores])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class Stream
      def self.default
        {
          stream_id: 'stream_id',
          blob: StringIO.new('blob')
        }
      end

      def self.stub(http_resp, stub: nil)
        http_resp.headers['StreamID'] = stub[:stream_id]
        http_resp.body = stub[:blob]
        http_resp.status = 200
      end
    end

    class HighScores
      def self.default
        {
          high_scores: []
        }
      end

      def self.stub(stub: [])
        stub.map do |stub|
          HighScoreAttributes.stub(stub)
        end
      end
    end

  end
end
