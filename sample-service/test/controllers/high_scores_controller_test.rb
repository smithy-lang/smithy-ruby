require "test_helper"

class HighScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @high_score = high_scores(:one)
  end

  test "should get index" do
    get high_scores_url, as: :json
    assert_response :success
  end

  test "should create high_score" do
    assert_difference('HighScore.count') do
      post high_scores_url, params: { high_score: { game: @high_score.game, score: @high_score.score } }, as: :json
    end

    assert_response 201
  end

  test "should show high_score" do
    get high_score_url(@high_score), as: :json
    assert_response :success
  end

  test "should update high_score" do
    patch high_score_url(@high_score), params: { high_score: { game: @high_score.game, score: @high_score.score } }, as: :json
    assert_response 200
  end

  test "should destroy high_score" do
    assert_difference('HighScore.count', -1) do
      delete high_score_url(@high_score), as: :json
    end

    assert_response 204
  end
end
