module Api
  class GamesController < Api::BaseController

    def index
      @games = Game.enabled.order(:title)
    end

  end
end