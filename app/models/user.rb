class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    def self.find_for_oauth(auth)
      user = User.where(uid: auth.uid, provider: auth.provider).first

      unless user
        user = User.create(
          email:    User.dummy_email(auth),
          password: Devise.friendly_token[0, 20],
          uid:      auth.uid,
          provider: auth.provider,
          name:     auth.info.name,
          nickname: auth.info.nickname,
          image:    auth.info.image,
          )
      end

      user
    end

    private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
