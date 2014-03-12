class InstagramInitialize
  
  def initialize
    Instagram.configure do |config|
      config.client_id =  ENV['INSTAGRAM_ID']
      config.client_secret = ENV['INSTAGRAM_SECRET']
      config.access_token = ENV['INSTAGRAM_ACCESS_TOKEN']
    end
  end
end


