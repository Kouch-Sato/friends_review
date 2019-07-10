class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    if @review.save
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
      # エラー文はまとめて考える
    end
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :content)
  end
end
