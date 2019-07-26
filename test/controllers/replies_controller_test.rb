require 'test_helper'

class RepliesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
    @other_user = users(:dara)
    @my_review = reviews(:yuri_review1)
    @other_review = reviews(:dara_review1)
  end

  def test_create_reply_to_own_review
    login_as(@current_user, scope: :user)

    assert_difference('Reply.all.count') do
      post replies_path,
            params: {
              reply: {
                review_id: @my_review.id,
                content: "そんな評価送られたら嬉しくなっちゃう"
              }
            }
    end

    assert_redirected_to check_book_path(@current_user.book)
    assert_equal Reply.last.review_id, @my_review.id
    assert_equal Reply.last.content, "そんな評価送られたら嬉しくなっちゃう"
    assert_equal flash[:notice], "承認し、コメントをツイートしました。"
  end

  def test_create_reply_to_other_review
    login_as(@current_user, scope: :user)

    assert_no_difference('Reply.all.count') do
      post replies_path,
            params: {
              reply: {
                review_id: @other_review.id,
                content: "そんな評価送られたら嬉しくなっちゃう"
              }
            }
    end

    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "権限がありません"
  end

  def test_create_reply_not_login_user
    assert_no_difference('Reply.all.count') do
      post replies_path,
            params: {
              reply: {
                review_id: @other_review.id,
                content: "そんな評価送られたら嬉しくなっちゃう"
              }
            }
    end

    assert_redirected_to root_path
  end
end
