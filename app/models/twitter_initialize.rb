class TwitterInitialize

  def initialize(current_user)
    user_obj = current_user
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user_obj.authentications.find_by_provider("twitter").token
      config.access_token_secret = user_obj.authentications.find_by_provider("twitter").secret
    end
  end

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