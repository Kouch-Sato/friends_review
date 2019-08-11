require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
    @other_user = users(:dara)
  end

  def test_books_show
    login_as(@current_user, scope: :user)
    get book_path(@current_user.book)
    assert_response :success
  end

  def test_books_edit_owner
    login_as(@current_user, scope: :user)
    get edit_book_path(@current_user.book)
    assert_response :success
  end

  def test_books_edit_other
    login_as(@current_user, scope: :user)
    get edit_book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end

  def test_books_check_owner
    login_as(@current_user, scope: :user)
    get check_book_path(@current_user.book)
    assert_response :success
  end

  def test_books_check_other
    login_as(@current_user, scope: :user)
    get check_book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end

  def test_books_reviewed_login_user
    login_as(@current_user, scope: :user)
    get reviewed_books_path
    assert_response :success
  end

  def test_books_reviewed_not_login_user
    get reviewed_books_path
    assert_redirected_to root_path
    assert_equal flash[:alert], "ログインまたは登録が必要です。"
  end
  #
  # def test_books_following_login_user
  #   login_as(@current_user, scope: :user)
  #   get following_books_path
  #   assert_response :success
  # end
  #
  # def test_books_following_not_login_user
  #   get following_books_path
  #   assert_redirected_to root_path
  #   assert_equal flash[:alert], "ログインまたは登録が必要です。"
  # end
end
