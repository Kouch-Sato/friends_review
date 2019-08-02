class Admin::UsersController < AdminController
  def index
    @users = User.all.order("created_at")
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @reviews_to_others = @user.reviews_to_others
  end
end