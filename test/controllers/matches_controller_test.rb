require 'test/test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    user= create(:user)
    opponent= create(:user)
    sign_in user
    game = create(:game)
    match = create(:match, game: game, player1_id: user.id, player2_id: opponent.id)
    get matches_path
    assert_response :success

    assert_equal @matches.first, match
  end

  test 'new' do
    user = create(:user)
    sign_in user
    get new_match_path
    assert_response :success
    assert_equal @user_games, assigns(:user_games)

    assert_equal @user_opponents, []
  end

end