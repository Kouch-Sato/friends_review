class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = @user.books.first
    @reviews = @book.reviews.checked
  end
end
