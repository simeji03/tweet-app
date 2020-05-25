class RenameRetweetIdColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :retweet_id, :retweet_user_id
  end
end
