class GamesController < ApplicationController
  include Pundit

  before_action :set_game, except: [:index]

  def index
    @games = Rails.cache.fetch('games_index') do
      policy_scope(Game).includes(:gamer_profiles, :matches, :users)
    end
  end

  def add
    authorize @game, :add?

    gp = GamerProfile.new(game: @game, user: current_user, handle: params[:handle])

    if gp.save
      flash[:notice] = "#{@game.title} has been added to your games"
    else
      render json: { errors: gp.errors[:handle] }, status: :unprocessable_entity
    end
  end

  def remove
    authorize @game, :remove?
    GamerProfile.where(game: @game, user: current_user).destroy_all
    redirect_to games_path, notice: "#{@game.title} has been removed from your games"
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

end
