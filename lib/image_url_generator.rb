module ImageUrlGenerator
  def self.cloudinary_books_show_url(encoded_avatar, width, y_axis, radius, base_image_version, base_image_name)
    "https://res.cloudinary.com/dsjn31fay/image/upload/l_fetch:#{encoded_avatar},w_#{width},y_#{y_axis},r_#{radius}/#{base_image_version}/friends_review/#{base_image_name}"
  end

  def self.cloudinary_reviews_show_url(width, font, font_size, text, y_axis, base_image_version, base_image_name)
    "https://res.cloudinary.com/dsjn31fay/image/upload/w_#{width},c_fit,l_text:#{font}_#{font_size}:#{text},y_#{y_axis}/#{base_image_version}/friends_review/#{base_image_name}"
  end
end
