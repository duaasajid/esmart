require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:ken)
    sign_in @user, scope: :user
  end

  test 'get show' do
    get dashboard_url
    assert_response :success
  end

  test 'get show when unauthenticated' do
    sign_out :user
    get dashboard_url
    assert_redirected_to new_user_session_url
  end

end
