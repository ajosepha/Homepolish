class InstagramUser
  def initialize(current_user)
    Instagram.configure do |config|
      config.client_id =  ENV['INSTAGRAM_ID']
      config.client_secret = ENV['INSTAGRAM_SECRET']
      config.access_token = current_user.authentications.find_by_provider("instagram").token
    end
  end
end