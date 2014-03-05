class AddIndexToinstagramDataInstagramId < ActiveRecord::Migration
  def change
    add_index :instagram_data, :user_id
  end
end
