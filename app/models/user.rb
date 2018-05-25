class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id',
                          dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 150 }
  validates :blog_url, length: { maximum: 70 }
  validates :twitter_url, length: { maximum: 70 }
  validate :image_size

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    profile = auth[:info][:description] ? auth[:info][:description] : ''
    blog_url =  ''
    twitter_url = auth[:info][:urls][:Twitter]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = user_name
      user.profile = profile
      user.blog_url = blog_url
      user.twitter_url = twitter_url
    end
  end

  def follow(other_user)
    relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def image_size
    if image_url.size > 2.megabytes
      errors.add(:image_url, '画像のサイズが大きすぎます')
    end
  end
end
