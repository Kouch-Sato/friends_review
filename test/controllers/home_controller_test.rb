require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  def test_home_top
    get root_path
    assert_response :success
  end

  def test_home_privacy
    get home_privacy_path
    assert_response :success
  end

  def test_terms_top
    get home_terms_path
    assert_response :success
  end
end
