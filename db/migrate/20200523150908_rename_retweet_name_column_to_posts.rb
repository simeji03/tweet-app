class RenameRetweetNameColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :retweet_name, :retweet_id
  end
end
