class Admin::UsersController < AdminController

  PER = 20

  def index
    @all_users = User.all
    @users = User.all.order("created_at").page(params[:page]).per(PER)
    @reviews = Review.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @reviews_to_others = @user.reviews_to_others
  end
end
