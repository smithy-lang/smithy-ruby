module SampleService
  # @api private
  module Stubs

    class HighScoreAttributes
      def self.stub(stub_data = {})
        data = {}
        data[:id] = stub_data[:id] || 'id'
        data[:game] = stub_data[:game] || 'game'
        data[:score] = stub_data[:score] || 0
        data[:created_at] = stub_data[:created_at] || Time.now
        data[:updated_at] = stub_data[:updated_at] || Time.now
        data
      end
    end

    class GetHighScore
      def self.stub(http_resp, stub_data)
        data = HighScoreAttributes.stub(stub_data[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class CreateHighScore
      def self.stub(http_resp, stub_data)
        data = HighScoreAttributes.stub(stub_data[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 201
      end
    end

    class UpdateHighScore
      def self.stub(http_resp, stub_data)
        data = HighScoreAttributes.stub(stub_data[:high_score])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class DeleteHighScore
      def self.stub(http_resp, stub_data)
        data = {}
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class ListHighScores
      def self.stub(http_resp, stub_data)
        data = HighScores.stub(stub_data[:high_scores])
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class Stream
      def self.stub(http_resp, stub_data)
        http_resp.headers['StreamID'] = stub_data[:stream_id] || 'stream_id'
        http_resp.body = stub_data[:blob] || StringIO.new('blob')
        http_resp.status = 200
      end
    end

    class HighScores
      def self.stub(stub_data = [])
        stub_data.map do |stub|
          HighScoreAttributes.stub(stub)
        end
      end
    end

  end
end
