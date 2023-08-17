module ApplicationHelper

  def find_game(game_id)
    Game.find(game_id)
  end
end
