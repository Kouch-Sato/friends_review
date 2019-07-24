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

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      # メモ：sign_in_and_redirectは、user_root_pathを最優先で探し、なければrootに行く。（https://qiita.com/masarakki/items/52751a49f9ec487169e4）
      # 今後user_rootを設定する必要あるかも。
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
