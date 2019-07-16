class HomeController < ApplicationController
  def top
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end

  def privacy
  end

  def terms
  end
end
