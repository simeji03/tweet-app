class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }}
  validates :password, {length:{minimum: 4}, unless: -> { validation_context == :update }}
  
  has_secure_password
  
  def posts
    return Post.where(user_id: self.id)
  end
end
