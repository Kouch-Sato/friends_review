class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :ensure_review_owner, only: [:update, :destroy]

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    if user_signed_in?
      @review.user_id = current_user.id
    end
    @review.status = "unchecked"
    if @review.save
      redirect_to book_path(@book), notice: "評価を送信しました。本人の承認後に公開されます。"
    else
      # urlが"books/:id/reviews"になるのでrenderは使わない
      redirect_to book_path(@book), alert: "1文字以上50文字以内で入力してください"
    end
  end

  def show
    @shared_review = Review.find(params[:id])
    @book = @shared_review.book
    @user = @book.user
    @review = Review.new
    @reviews = @book.reviews.checked.order("review_type")
    if user_signed_in?
      # TODO:pgの容量のバグ
      # @following_books = current_user.following_books.limit(3)
      @following_books = current_user.reviewed_books.limit(3)
    end
    render "books/show"
  end

  def update
    @review = Review.find(params[:id])
    @book = @review.book
    @review.checked!
    redirect_to check_book_path(@book), notice: "評価を承認しました"
  end

  def destroy
    @review = Review.find(params[:id])
    @review.deleted!
    redirect_back(fallback_location: user_path(current_user), notice: "評価を削除しました")
  end

  private
  def review_params
    params.require(:review).permit(:review_type, :content)
  end

  def ensure_review_owner
    @review = Review.find(params[:id])
    unless current_user.id == @review.book.user_id
      redirect_to user_path(current_user), alert: "他の人の評価は編集できません"
    end
  end
end
