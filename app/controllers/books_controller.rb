class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :check, :update, :commented_index, :following_index]
  before_action :ensure_book_owner, only: [:edit, :check, :update]
  before_action :ensure_corrent_user, only: [:commented_index, :following_index]

  # TODO PERは後に大きくする（テスト用）
  PER = 2

  def commented_index
    @books = Book.commented_by(current_user).page(params[:page]).per(PER)
    render "books/index"
  end

  # TODO：今は全てのbooksを取得しているので直す
  def following_index
    @user = User.find(params[:id])
    @books = Book.page(params[:page]).per(PER)
    render "books/index"
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

  def ensure_corrent_user
    unless current_user.id == params[:id].to_i
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end
end
