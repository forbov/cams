# encoding: utf-8 
class User < ActiveRecord::Base 
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 8 }
  validates :council_id, presence: true
  validates :user_role_code, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  belongs_to :council 
  belongs_to :user_role
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def full_name
    return self.first_name + " " + self.last_name
  end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end