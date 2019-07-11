class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = @user.book
    @reviews = @book.reviews.checked
  end
end
