require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
    @other_user = users(:dara)
  end

  def test_books_show
    get user_path(@current_user)
    assert_response :success
  end

  def test_destroy_user
    login_as(@current_user, scope: :user)

    books_count =   @current_user.books.count
    reviews_count = @current_user.reviews.count
    reply_count =   @current_user.replies.count

    reviews_to_others = @current_user.reviews_to_others

    assert_difference('User.all.count', -1) do
      assert_difference('Book.all.count', -1 * books_count) do
        assert_difference('Review.all.count', -1 * reviews_count) do
          assert_difference('Reply.all.count', -1 * reply_count) do
            delete user_path(@current_user)
          end
        end
      end
    end

    reviews_to_others.each do |review|
      assert_nil review.user_id
    end

    assert_redirected_to root_path
    assert_equal flash[:notice], "アカウントを削除しました"
  end

  def test_destroy_user_from_others
    login_as(@current_user, scope: :user)

    delete user_path(@other_user)

    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "権限がありません"
  end

  def test_destroy_user_not_login_user
    delete user_path(@other_user)

    assert_redirected_to root_path
  end

  def test_logout_user
    login_as(@current_user, scope: :user)

    delete destroy_user_session_path
    assert_redirected_to root_path
    assert_equal flash[:notice], I18n.t('devise.sessions.signed_out')
  end
end
