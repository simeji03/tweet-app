class RemoveRetweetUserIdFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :retweet_user_id, :integer
  end
end
