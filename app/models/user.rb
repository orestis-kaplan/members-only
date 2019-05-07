class User < ApplicationRecord
  before_create :create_remember_token
  has_secure_password
  has_many :posts, dependent: :destroy

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
end
