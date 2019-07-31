module BooksHelper
  require 'base64'

  def books_show_meta_tags
    if @shared_review.present?
      image_url = reviews_show_og_image_url(@shared_review)
    else
      image_url = books_show_og_image_url(@user)
    end
    {
      title: "#{@user.name}の通信簿",
      og: {
        title: "#{@user.name}の通信簿です",
        image: image_url,
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

  def reviews_show_og_image_url(review)
    width              = 450
    font               = "Sawarabi%20Gothic"
    font_size          = 30
    text               = create_review_show_text(review)
    y_axis             = 5
    base_image_version = "v1564554855"
    base_image_name    = "review.png"
    ImageUrlGenerator.cloudinary_reviews_show_url(width, font, font_size, text, y_axis, base_image_version, base_image_name)
  end

  def books_show_twitter_share_url(user)
    url             = request.url
    text            = "#{user.name}の通信簿です！記入したり、結果を覗いたりしよう！"
    hash_tags_array = ["みんなの通信簿"]
    ShareUrlGenerator.twitter_share_url(url, text, hash_tags_array)
  end

  private
  def create_review_show_text(review)
    review_symbol  = review.review_type == "good" ? "◯" : "✕"
    review_content = review.content
    return review_symbol + " " + review_content
  end
end
