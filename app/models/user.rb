class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  mount_uploader :image_url, PictureUploader
  validates :name, presence: true, length: { maximum: 50 }
  validate :image_size

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = '名無しさん'
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
