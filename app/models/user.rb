# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  image                  :string(255)
#

class User < ApplicationRecord
  has_many :books
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
