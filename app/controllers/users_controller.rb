class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :ensure_login_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
    @book = @user.book
    @review = Review.new
    @reviews = @book.reviews.checked.order("review_type")
    if user_signed_in?
      @following_books = current_user.following_books.limit(3)
    end
    render "books/show"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private
  def ensure_login_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
