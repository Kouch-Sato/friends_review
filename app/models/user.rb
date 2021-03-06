# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  access_token           :string(255)
#  access_token_secret    :string(255)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  image                  :string(255)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  uid                    :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :reviews, through: :books
  has_many :replies, through: :reviews
  has_many :reviews_to_others, class_name: "Review", dependent: :nullify
  has_many :user_twitter_followings
  has_many :twitter_followings, through: :user_twitter_followings

  validates :email,    presence: true
  validates :provider, presence: true
  validates :uid,      presence: true
  validates :name,     presence: true
  validates :nickname, presence: true
  validates :image,    presence: true

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  def book
    books.first
  end

  def reviewed_books
    reviewed_book_ids = reviews_to_others.pluck(:book_id).uniq
    Book.where(id: reviewed_book_ids)
  end

  def following_books
    Book.where(user_id: twitter_followings.pluck(:id))
  end

  def is_admin?
    admin_uids = [ENV.fetch("TWITTER_KOUCH_UID").to_i, ENV.fetch("TWITTER_DARA_UID").to_i]
    admin_uids.include?(uid)
  end

  def self.find_by_sns_account(sns_account)
    self.where(
      uid: sns_account.uid,
      provider: sns_account.provider
    ).first
  end

  def self.create_by_sns_account(sns_account)
    self.create(
      email:               User.dummy_email(sns_account),
      password:            Devise.friendly_token[0, 20],
      uid:                 sns_account.uid,
      provider:            sns_account.provider,
      name:                sns_account.info.name,
      nickname:            sns_account.info.nickname,
      image:               User.secure_image_url(sns_account.info.image),
      access_token:        sns_account.credentials.token,
      access_token_secret: sns_account.credentials.secret,
    )
  end

  def update_by_sns_account(sns_account)
    self.update(
      access_token:        sns_account.credentials.token,
      access_token_secret: sns_account.credentials.secret,
    )
  end

  private
  def self.dummy_email(sns_account)
    "#{sns_account.uid}-#{sns_account.provider}@example.com"
  end

  def self.secure_image_url(image_url)
    if image_url.start_with?("http://")
      image_url.gsub!(/http:\/\//, "https://")
    end

    image_url
  end
end
