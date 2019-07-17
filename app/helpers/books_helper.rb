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
    "https://res.cloudinary.com/dsjn31fay/image/upload/l_text:Sawarabi%20Gothic_40:1年1組%20#{user.name},co_white,g_south_east,x_55,y_120/v1563278350/friends_review/blackboard.jpg"
  end

  def books_show_twitter_share_url(user)
    "https://twitter.com/share?url=#{request.url}/&text=#{user.name}の通信簿です！記入したり、結果を覗いたりしよう！&hashtags=みんなの通信簿"
  end
end
