class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.books.first.reviews
  end
end
