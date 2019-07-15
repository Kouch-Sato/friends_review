class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = @user.book
    @review = Review.new
    @reviews = @book.reviews.checked
  end
end
