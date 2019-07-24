require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_user = users(:yuri)
    @other_user = users(:dara)
    @my_review = reviews(:yuri_review1)
    @other_review = reviews(:dara_review1)
  end

  def test_review_create_login_user
    login_as(@current_user, scope: :user)

    assert_difference('@other_user.book.reviews.count') do
      post book_reviews_path(@other_user.book),
           params: {
             review: {
               content: "お前は最高だぜ！",
               review_type: "good"
             }
           }
    end

    assert_redirected_to book_path(@other_user.book)
    assert_equal Review.last.user_id, @current_user.id
    assert_equal Review.last.content, "お前は最高だぜ！"
    assert_equal Review.last.review_type, "good"
    assert_equal flash[:notice], "評価を送信しました。本人の承認後に公開されます。"
  end

  def test_review_create_not_login_user
    assert_difference('@other_user.book.reviews.count') do
      post book_reviews_path(@other_user.book),
           params: {
             review: {
               content: "お前は最高だぜ！",
               review_type: "good"
             }
           }
    end

    assert_redirected_to book_path(@other_user.book)
    assert_nil Review.last.user_id
    assert_equal Review.last.content, "お前は最高だぜ！"
    assert_equal Review.last.review_type, "good"
    assert_equal flash[:notice], "評価を送信しました。本人の承認後に公開されます。"
  end

  def test_review_create_with_empty_content
    assert_difference('@other_user.book.reviews.count', 0) do
      post book_reviews_path(@other_user.book),
           params: {
             review: {
               content: "",
               review_type: "good"
             }
           }
    end

    assert_redirected_to book_path(@other_user.book)
    assert_equal flash[:alert], "1文字以上50文字以内で入力してください"
  end

  def test_review_delete_owner
    login_as(@current_user, scope: :user)

    assert_difference('@current_user.book.reviews.deleted.count') do
      delete book_review_path(@current_user.book, @my_review)
    end

    assert_equal flash[:notice], "評価を削除しました"
  end

  def test_review_delete_other
    login_as(@current_user, scope: :user)

    assert_difference('@other_user.book.reviews.deleted.count', 0) do
      delete book_review_path(@other_user.book, @other_review)
    end

    assert_redirected_to user_path(@current_user)
    assert_equal flash[:alert], "他の人の評価は編集できません"
  end
end
