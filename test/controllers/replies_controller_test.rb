require 'test_helper'

class RepliesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get replies_create_url
    assert_response :success
  end

end
