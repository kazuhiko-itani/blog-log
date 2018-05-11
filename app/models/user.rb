class User < ApplicationRecord

  before_save :downcase_address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  has_secure_password

  private

    def downcase_address
      self.email.downcase!
    end
end