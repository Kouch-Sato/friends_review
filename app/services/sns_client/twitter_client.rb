module SnsClient
  class TwitterClient
    def initialize(user)
      @user = user
      set_twitter_client_config
    end

    # API制限:ユーザーにつき15times/15m
    def update_twitter_follower
      @user.user_twitter_followers.delete_all

      follower_uids = @client.friend_ids
      follower_uids.each do |follower_uid|
        @user.user_twitter_followers.create(twitter_follower_uid: follower_uid)
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