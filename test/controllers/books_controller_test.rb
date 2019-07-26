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

  def test_books_update_owner
    login_as(@current_user, scope: :user)
    unchecked_count = @current_user.book.reviews.unchecked.count
    checked_count = @current_user.book.reviews.checked.count
    patch book_path(@current_user.book)

    assert_redirected_to user_path(@current_user)
    assert_equal @current_user.book.reviews.unchecked.count, 0
    assert_equal @current_user.book.reviews.checked.count, unchecked_count + checked_count
    assert_equal flash[:notice], "評価をまとめて承認しました"
  end

  def test_books_update_other
    login_as(@current_user, scope: :user)
    patch book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end

  def test_books_commented_login_user
    login_as(@current_user, scope: :user)
    get commented_books_path
    assert_response :success
  end

  def test_books_commented_not_login_user
    get commented_books_path
    assert_redirected_to root_path
  end
end
