class BooksController < ApplicationController
  def show
    @book = Book.find_by(id: params[:id])
    @user = @book.user
    @review = Review.new
    @reviews = @book.reviews.checked
  end

  def edit
    @book = Book.find_by(id: params[:id])
    @checked_reviews = @book.reviews.checked
  end

  def check
    @book = Book.find_by(id: params[:id])
    @unchecked_reviews = @book.reviews.unchecked
  end

  def update
    @book = Book.find_by(id: params[:id])
    @reviews = @book.reviews.unchecked
    @reviews.map(&:checked!)
    redirect_to user_path(@book.user)
  end
end
