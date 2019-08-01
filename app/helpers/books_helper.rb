module BooksHelper
  require 'base64'

  def books_show_meta_tags

    image_url = set_image_url

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
    base_image_version = "v1564473266"
    base_image_name    = "book_top.png"
    option             = "l_fetch:#{encoded_avatar},w_1.8,y_70,r_50"
    OgpUrlGenerator.cloudinary_ogp_url(base_image_version, base_image_name, option)
  end

  def reviews_show_og_image_url(review)
    text               = create_review_show_text(review)
    base_image_version = "v1564637855"
    base_image_name    = "review.png"
    option             = "w_430,c_fit,l_text:Sawarabi%20Gothic_30:#{text},y_15"
    OgpUrlGenerator.cloudinary_ogp_url(base_image_version, base_image_name, option)
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

  def set_image_url
    image_url = books_show_og_image_url(@user)
    if @shared_review.present?
      image_url = reviews_show_og_image_url(@shared_review)
    end
    return image_url
  end
end
