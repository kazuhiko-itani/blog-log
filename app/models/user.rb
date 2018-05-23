class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 150 }
  validates :blog_url, length: { maximum: 100 }
  validate :image_size

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    user_image = auth[:info][:image]
    profile = auth[:info][:description] ? auth[:info][:description] : ''
    blog_url = auth[:info][:website] ? auth[:info][:website] : ''
    twitter_url = auth[:info][:urls][:Twitter]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = user_name
      user.profile = profile
      user.blog_url = blog_url
    end
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def image_size
    if image_url.size > 5.megabytes
      errors.add(:image_url, '画像のサイズが大きすぎます')
    end
  end
end
