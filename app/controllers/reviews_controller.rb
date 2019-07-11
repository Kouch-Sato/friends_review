class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.unchecked!
    if @review.save
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
      # エラー文はまとめて考える
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: params[:book_id])
    @review.deleted!
    redirect_to edit_book_path(@book)
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :content)
  end
end
