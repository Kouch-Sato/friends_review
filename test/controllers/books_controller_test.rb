require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user =users(:yuri)
    @other_user = users(:dara)
    login_as(@current_user, scope: :user)
  end

  def test_books_show
    get book_path(@current_user.book)
    assert_response :success
  end

  def test_books_edit_owner
    get edit_book_path(@current_user.book)
    assert_response :success
  end

  def test_books_edit_other
    get edit_book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end

  def test_books_check_owner
    get check_book_path(@current_user.book)
    assert_response :success
  end

  def test_books_check_other
    get check_book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end

  def test_books_update_owner
    unchecked_count = @current_user.book.reviews.unchecked.count
    checked_count = @current_user.book.reviews.checked.count
    patch book_path(@current_user.book)

    assert_redirected_to user_path(@current_user)
    assert_equal @current_user.book.reviews.unchecked.count, 0
    assert_equal @current_user.book.reviews.checked.count, unchecked_count + checked_count
    assert_equal flash[:notice], "評価をまとめて承認しました"
  end

  def test_books_update_other
    patch book_path(@other_user.book)
    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の通信簿は編集できません"
  end
end
