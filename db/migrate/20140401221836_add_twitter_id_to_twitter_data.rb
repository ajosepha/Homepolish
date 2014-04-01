class AddTwitterIdToTwitterData < ActiveRecord::Migration
  def change
    add_column :twitter_data, :twitter_id, :integer
  end
end
