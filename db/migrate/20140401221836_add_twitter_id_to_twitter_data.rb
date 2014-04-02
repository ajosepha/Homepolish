class AddTwitterIdToTwitterData < ActiveRecord::Migration
  def change
    add_column :twitter_data, :follower_id, :integer
  end
end
