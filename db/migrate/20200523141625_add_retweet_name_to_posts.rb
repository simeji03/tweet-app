class AddRetweetNameToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :retweet_name, :string
  end
end
