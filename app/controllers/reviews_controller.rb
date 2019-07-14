class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    if user_signed_in?
      @review.user_id = current_user.id
    end
    @review.status = "unchecked"
    if @review.save
      redirect_to book_path(@book), notice: "評価を送信しました"
    else
      # urlが"books/:id/reviews"になるのでrenderは使わない
      redirect_to book_path(@book), alert: "1文字以上30文字以内で入力してください"
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: params[:book_id])
    @review.deleted!
    redirect_to edit_book_path(@book), notice: "評価を削除しました"
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :content)
  end
end
