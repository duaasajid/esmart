require 'test/test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest

  test 'get index' do
    user = create(:user)
    sign_in user
    get games_path
    assert_response :success

    assert_equal @games.count, user.games.count
  end

  test 'post add' do
    user = create(:user)
    sign_in user
    game = create(:game)
    post games_path, params: { game_id: game.id, handle: 'test_handle' }

    assert_equal flash[:notice], 'The game has been added to your games.'
  end

end
