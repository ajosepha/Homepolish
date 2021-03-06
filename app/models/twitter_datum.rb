class TwitterDatum < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :username, :bio, :location, :followers_count, :user_id, :follower_id
  validates_uniqueness_of :username, scope: :user_id


  def tw_follower_ids
    twitter_connect = TwitterInitialize.new
    @client = twitter_connect.new_client
    @array = @client.follower_ids.to_a
    rescue Twitter::Error::TooManyRequests => error
      p error
      p 'tw_follower_ids sleep ' + error.rate_limit.reset_in.to_s
      sleep error.rate_limit.reset_in
    retry
  end
  # end

  def make_array
    @twitter_hashes= []
    @array.each do |id|
      @twitter_hashes << {:follower_id => id}
      @twitter_hashes
    end
  end

  def self.save_followers_id
    @twitter_hashes.each do |element|
      d = TwitterDatum.new(element)
      d.user_id = current_user
      d.save
    end
  end

  def find_followers_to_query
    @update = InstagramDatum.where(username: nil)
  end


end