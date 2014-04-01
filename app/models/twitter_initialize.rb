class TwitterInitialize

  # def initialize(current_user)
  #   user_obj = current_user
  #   @client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['TWITTER_KEY']
  #     config.consumer_secret     = ENV['TWITTER_SECRET']
  #     config.access_token        = user_obj.authentications.find_by_provider("twitter").token
  #     config.access_token_secret = user_obj.authentications.find_by_provider("twitter").secret
  #   end
  # end

  def initialize(current_user)
    user_obj = current_user
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "hM8HnQ75aT8LZqAuJUI73bnT9"
      config.consumer_secret     = "5UtJWmyS7VKR2lUa0TpE3mCprYBfmxEI1dzJlX6IVaAAafQOMc"
      config.access_token        = "1326092978-eLe8nlYO85MknA1GIVYqc3OfqbRnNtL2q2DXDMI"
      config.access_token_secret = "4N0ksHX8ZxnOzkOGNBVO9eTFgSAyAtcFAwxNFLf6dGPft"
    end
  end

  # def find_followers
  #  @client.followers   
  # end

  # def get_info
  #   @followers = find_followers
  #   @followers.attrs[:users]
  # end

  def find_followers
    @info_array = []
    @client.followers.each do |person|
      @info_array << { :name => person.name,
      :username => person.username, 
      :bio => person.description,
      :followers_count => person.followers_count,
      :location => person.location }
    end
    @info_array
  end

end