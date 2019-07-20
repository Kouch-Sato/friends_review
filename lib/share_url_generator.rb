module ShareUrlGenerator
  def self.twitter_share_url(url, text, hash_tags_array)
    hash_tags = hash_tags_array.join(",")
    "https://twitter.com/share?url=#{url}&text=#{text}&hashtags=#{hash_tags}"
  end
end