class Admin::UsersController < AdminController
  def index
    @users = User.all.order("created_at")
  end

  def show
    @user = User.find_by(id: params[:id])
    @review = @user.reviews
    @review_to_others = @user.review_to_others
  end
end