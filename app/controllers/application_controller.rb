class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def calculate_user_statistics
    current_user.matches_played.finished.group(:game_id).pluck(
    :game_id,
    "COUNT(*) as total_matches",
    "SUM(CASE WHEN winner_id = #{current_user.id} THEN 1 ELSE 0 END) as match_won",
    "SUM(CASE WHEN winner_id != #{current_user.id} THEN 1 ELSE 0 END) as match_lost",
  )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :remove_avatar])
  end

end
