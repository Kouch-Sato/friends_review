module UsersHelper
  def twitter_url(user)
    "https://twitter.com/#{user.nickname}"
  end
end