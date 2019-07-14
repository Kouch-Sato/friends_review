class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :check, :update]
  before_action :ensure_book_owner, only: [:edit, :check, :update]

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
    redirect_to user_path(@book.user), notice: "評価をまとめて承認しました"
  end

  private
  def ensure_book_owner
    @book = Book.find_by(id: params[:id])
    unless current_user.id == @book.user_id
      redirect_to user_path(current_user), alert: "他の人の通信簿は編集できません"
    end
  end
end
