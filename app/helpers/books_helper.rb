module BooksHelper
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
    font_size = 40
    text      = "1年1組%20#{user.name}"
    option    = "co_white,g_south_east,x_55,y_120"
    version   = "v1563278350"
    image     = "blackboard.jpg"
    ImageUrlGenerator.cloudinary_share_url(font_size, text, option, version, image)
  end

  def books_show_twitter_share_url(user)
    url             = request.url
    text            = "#{user.name}の通信簿です！記入したり、結果を覗いたりしよう！"
    hash_tags_array = ["みんなの通信簿"]
    ShareUrlGenerator.twitter_share_url(url, text, hash_tags_array)
  end
end
