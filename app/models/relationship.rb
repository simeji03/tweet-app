class Relationship < ApplicationRecord
  
  # Userモデルに関連するfollowモデルを疑似的に定義した上でリレーションする
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
