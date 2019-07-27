class RepliesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :ensure_review_owner, only: [:create]

  def create
    @review = Review.find(params[:review_id])
    @book = @review.book
    @reply = @review.replies.new(reply_params)
    # TODO: Tweetする機能の実装
    # TODO: replyモデルに保存するときに、urlとハッシュタグを削除する
    if @reply.save!
      @review.checked!
      redirect_to check_book_path(@book), notice: "承認し、コメントをツイートしました。"
    else
      redirect_to check_book_path(@book), alert: "承認とツイートに失敗しました。"
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:content)
  end

  def ensure_review_owner
    @review = Review.find(params[:review_id])
    unless current_user.id == @review.book.user_id
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
