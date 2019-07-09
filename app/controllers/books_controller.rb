class BooksController < ApplicationController
  def show
    @book = Book.find_by(id: params[:id])
    @user = @book.user
    @review = Review.new
    @reviews = @book.reviews
  end
end
