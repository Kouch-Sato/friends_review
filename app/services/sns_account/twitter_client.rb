module SnsAccount
  class TwitterClient
    def initialize(user)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = user.access_token
        config.access_token_secret = user.access_token_secret
      end
    end

    def tweet(text)
      @client.update(text)
    end

    def follow_users
      @client.friend_ids
    end
  end
end