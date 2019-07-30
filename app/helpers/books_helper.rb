module BooksHelper
  require 'base64'
  def books_show_meta_tags
    {
      title: "#{@user.name}の通信簿",
      og: {
        title: "#{@user.name}の通信簿です",
        image: books_show_og_image_url(@user),
      }
    }
  end

  def books_show_og_image_url(user)
    base_image_name    = "book_top.png"
    base_image_version = "v1564473266"
    encoded_avatar     = Base64.encode64(user.image)
    option             = "l_fetch:#{encoded_avatar},w_1.8,y_70,r_50"
    ImageUrlGenerator.cloudinary_share_url(option, base_image_version, base_image_name)
  end

  def books_show_twitter_share_url(user)
    url             = request.url
    text            = "#{user.name}の通信簿です！記入したり、結果を覗いたりしよう！"
    hash_tags_array = ["みんなの通信簿"]
    ShareUrlGenerator.twitter_share_url(url, text, hash_tags_array)
  end
end
