class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from("twitter")
  end

  private
  def callback_from(provider)
    sns_account = request.env['omniauth.auth']
    @user = User.find_by_sns_account(sns_account)
    if @user.nil?
      @user = User.create_by_sns_account(sns_account)
      @user.books.create
    else
      @user.update_by_sns_account(sns_account)
    end

    # TODO:pgの容量的に一旦無視
    # twitter_client = SnsClient::TwitterClient.new(@user)
    # twitter_client.update_twitter_following

    if @user.persisted?
      flash[:notice] = I18n.t('devise.sessions.signed_in')
      sign_in_and_redirect @user, event: :authentication
    else
      # 基本的にこの処理は通らないが安全のため
      flash[:notice] = "Twitterログインに失敗しました"
      redirect_to root_url
    end
  end

  # ログイン後のpathを指定
  def after_sign_in_path_for(user)
    user_path(user)
  end
end
