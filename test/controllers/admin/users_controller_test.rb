require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
  end

  def test_admin_user_index_with_admin
    @current_user.uid = ENV.fetch("TWITTER_KOUCH_UID")
    login_as(@current_user, scope: :user)
    get admin_users_path

    assert_response :success
  end

  def test_admin_user_index_with_not_admin
    login_as(@current_user, scope: :user)
    get admin_users_path

    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "不正なアクセスです"
  end

  def test_admin_user_index_without_login
    get admin_users_path

    assert_redirected_to root_path
    assert_equal flash[:alert], "ログインまたは登録が必要です"
  end
end
