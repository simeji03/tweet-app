class ChangeColumnRetweetNameToPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :retweet_name, :integer
  end
end
