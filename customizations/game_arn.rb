# frozen_string_literal: true


module SampleService
  module Middleware
    # Resolve GameArns
    class GameArn
      def initialize(app, disable_game_arn:, params:)
        @app = app
        @disable_game_arn = disable_game_arn
        @params = params
      end

      def call(request:, response:, context:)
        return if @disable_game_arn

        @params[:id] ||= @params[:game_arn]&.split(':')&.last
      end
    end
  end
end
