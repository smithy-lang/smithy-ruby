class HighScoresController < ApplicationController
  before_action :set_high_score, only: [:show, :update, :destroy]
  # GET /high_scores
  def index
    @high_scores = HighScore.all

    render json: {
      high_scores: @high_scores,
      next_token: "#{params[:next_token]}_iter"
    }
  end

  # GET /high_scores/1
  def show
    render json: @high_score
  end

  # POST /high_scores
  def create
    @high_score = HighScore.new(high_score_params)

    if @high_score.save
      render json: @high_score, status: :created, location: @high_score
    else
      headers['x-smithy-error'] = 'UnprocessableEntityError'
      render json: @high_score.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /high_scores/1
  def update
    if @high_score.update(high_score_params)
      render json: @high_score
    else
      headers['x-smithy-error'] = 'UnprocessableEntityError'
      render json: @high_score.errors, status: :unprocessable_entity
    end
  end

  # DELETE /high_scores/1
  def destroy
    @high_score.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_high_score
      @high_score = HighScore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def high_score_params
      params.require(:high_score).permit(:game, :score, :time)
    end
end
