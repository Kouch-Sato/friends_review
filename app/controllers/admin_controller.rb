class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_user

  private
  def ensure_admin_user
    unless current_user.is_admin?
      redirect_to user_path(current_user), alert: "不正なアクセスです"
    end
  end
end
