class User < ApplicationRecord
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }}
  validates :password, {length:{minimum: 4}, unless: -> { validation_context == :update }}
  has_secure_password
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  # 自分がフォローしようとしている相手が自分自身ではないか検証し、既にフォロー済みではないか確認後フォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  # 自分が相手をフォローしているかどうかを確認し、フォローしていれば削除する
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  # フォローしているユーザーを取得し、include?で相手ユーザーが含まれていないか確認する
  def following?(other_user)
    self.followings.include?(other_user)  # フォローしていればtrue、フォローしていなければfalseを返す
  end
  
end
