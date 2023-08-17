class DashboardsController < ApplicationController

  def show
    @current_matches = Match.in_progress.order(created_at: :desc).limit(3).decorate
    @count_matches_won = current_user.matches_won.size
    @user_game_statistics = calculate_user_statistics
  end
end