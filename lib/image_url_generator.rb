module ImageUrlGenerator
  def self.cloudinary_share_url(base_image_version, base_image_name, option = "")
    option << "/" if option.present?
    "https://res.cloudinary.com/dsjn31fay/image/upload/#{option}#{base_image_version}/friends_review/#{base_image_name}"
  end
end
