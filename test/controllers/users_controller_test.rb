require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
  end

  def test_books_show
    get user_path(@current_user)
    assert_response :success
  end
end
