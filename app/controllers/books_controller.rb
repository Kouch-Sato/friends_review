class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :check, :reviewed, :following]
  before_action :ensure_book_owner, only: [:edit, :check]

  PER = 20

  def reviewed
    @books = current_user.reviewed_books.page(params[:page]).per(PER)
  end

  def following
    @books = current_user.following_books.page(params[:page]).per(PER)
  end

  def show
    @book = Book.find_by(id: params[:id])
    @user = @book.user
    @review = Review.new
    @reviews = @book.reviews.checked.order("review_type")
  end

  def edit
    @book = Book.find_by(id: params[:id])
    @checked_reviews = @book.reviews.checked
  end

  def check
    @book = Book.find_by(id: params[:id])
    @unchecked_reviews = @book.reviews.unchecked
    @reply = Reply.new
  end

  private
  def ensure_book_owner
    @book = Book.find_by(id: params[:id])
    unless current_user.id == @book.user_id
      redirect_to user_path(current_user), alert: "他の人の通信簿は編集できません"
    end
  end
end
