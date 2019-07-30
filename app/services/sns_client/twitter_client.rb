module SnsClient
  class TwitterClient
    def initialize(user)
      @user = user
      set_twitter_client_config
    end

    # API制限:ユーザーにつき15times/15m
    def update_twitter_following
      @user.user_twitter_followings.delete_all

      following_uids = @client.friend_ids
      following_uids.each do |following_uid|
        @user.user_twitter_followings.create(twitter_following_uid: following_uid)
      end
    end

    def tweet(text)
      @client.update(text)
    end

    private
    def set_twitter_client_config
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = @user.access_token
        config.access_token_secret = @user.access_token_secret
      end
    end
  end
end