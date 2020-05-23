class Post < ApplicationRecord
  
  has_many :retweets
  
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  def retweeted?(user)
    retweets.where(user_id: user.id).exists?
  end
end
