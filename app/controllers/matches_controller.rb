class MatchesController < ApplicationController
  include Pundit

  def index
    @matches = policy_scope(Match).
        includes(:game, :player1, :player2).
        order(created_at: :desc).
        decorate
  end

  def new
    @user_games = current_user.games || []
    @user_opponents = []
  end

  def create
    remap_params_for_match_create
    @match = Match.new(match_params)
    if @match.save
      redirect_to root_path, notice: 'Match was successfully created.'
    else
      render :new
    end
  end

  def user_game_opponents
    @user_opponents = User.opponents(current_user.id, params[:gameId])
    render partial: 'opponents_dropdown', locals: { opponents: @user_opponents }
  end

  private
  def match_params
    params.permit(:game_id, :player1_id, :player2_id, :winner_id)
  end

  def remap_params_for_match_create
    params[:match] ||= {}
    params[:game_id] = params[:game_id]
    params[:player1_id] = current_user.id    
    params[:player2_id] = params[:match][:opponent_id]
  end

end
