class ChangeFollowsToRelationships < ActiveRecord::Migration[5.1]
  def change
    rename_table :follows, :relationships
  end
end
