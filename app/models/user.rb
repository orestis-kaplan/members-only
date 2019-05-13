class User < ApplicationRecord
  before_create :create_remember_token
  before_save { email.downcase! }
  has_secure_password
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates  :email, presence: true ,length: {maximum: 255},
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }

  validates :password ,presence: true ,length: {minimum: 6}, allow_nil: true

  private

  def create_remember_token
    self.remember_token = generate_token
  end

  def generate_token
    token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
    token
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  def downcase_email
    email.downcase!
  end
end
