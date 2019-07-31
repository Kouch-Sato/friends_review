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
    encoded_avatar     = Base64.strict_encode64(user.image)
    width              = 1.8
    y_axis             = 70
    radius             = 50
    base_image_version = "v1564473266"
    base_image_name    = "book_top.png"
    ImageUrlGenerator.cloudinary_books_show_url(encoded_avatar, width, y_axis, radius, base_image_version, base_image_name)
  end

  def books_show_twitter_share_url(user)
    url             = request.url
    text            = "#{user.name}の通信簿です！記入したり、結果を覗いたりしよう！"
    hash_tags_array = ["みんなの通信簿"]
    ShareUrlGenerator.twitter_share_url(url, text, hash_tags_array)
  end
end
