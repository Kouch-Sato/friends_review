class RepliesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :ensure_review_owner, only: [:create]

  def create
    @reply = Reply.new(reply_params)
    @review = Review.find(@reply[:review_id])
    @book = @review.book
    # TODO: Tweetする機能の実装
    # TODO: サーバーで140文字バリデーションをかける
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
    params.require(:reply).permit(:review_id, :content)
  end

  def ensure_review_owner
    @review = Review.find_by(id: params[:reply][:review_id])
    unless current_user.id == @review.book.user_id
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
