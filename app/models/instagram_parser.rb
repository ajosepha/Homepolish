
class InstagramParser
  
  attr_accessor :data, :info_array, :user_obj

  def initialize(user_obj)
    @user_obj = user_obj
    Instagram.configure do |config|
      config.client_id =  ENV['INSTAGRAM_ID']
      config.client_secret = ENV['INSTAGRAM_SECRET']
      config.access_token = user_obj.authentications.find_by_provider("instagram").token
    end
    @data = Instagram.user_followed_by(user_obj.authentications.find_by_provider("instagram").uid, :count => -1)
    @info_array = []
  end

  
  def find_id
    new_array = []
    @data.each do |hash|
      #id as symbol?
      new_array << hash["id"].to_i
    end
    new_array
  end

  def target_data(id)
      user = Instagram.user(id)
      @info_array << {
        :instagram_id => user["id"],
        :username => user["username"],
        :bio => user["bio"],
        :name => user["full_name"],
        :followers_count => user["counts"]["followed_by"]
      }
  end

  def sort_followers(array, hash_key)
    array.sort_by {|hash| hash[hash_key]}.reverse
  end

  def parse_and_sort
      find_id.each do |id|a 
        begin
        target_data(id)
        rescue 
          next
        end
      end
    sort_followers(info_array, :followers_count)
  end


end