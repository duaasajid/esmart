require 'test_helper'

module Api
  class GamesControllerTest < ActionDispatch::IntegrationTest

    test 'get index' do
      get api_games_url(subdomain: :api), as: :json
      assert_response :success
      assert_equal expected_json, JSON.parse(response.body, symbolize_names: true)
    end

    private

    def expected_json
      [
          {
              id: 418230605,
              title: 'League of Legends',
              slug: 'lol'
          },
          {
            id: 475801831,
            title: "PlayerUnknown's Battlegrounds",
            slug: 'pubg'
          },
          {
            id: 50017330,
            title: 'World of Warcraft',
            slug: 'wow'
          }
      ]
    end

  end
end