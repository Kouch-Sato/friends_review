module ImageUrlGenerator
  def self.cloudinary_share_url(font_size, text, option, version, image)
    "https://res.cloudinary.com/dsjn31fay/image/upload/l_text:Sawarabi%20Gothic_#{font_size}:#{text},#{option}/#{version}/friends_review/#{image}"
  end
end