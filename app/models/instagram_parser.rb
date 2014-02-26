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

  # def find_locations_for_users
  #   find_id.each do |id|
  #     get_location(id)
  #   end
  # end

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
        :followers_count => user["counts"]["followed_by"],
        :location => get_location(id).first
      }
  end

  def sort_followers(array, hash_key)
    array.sort_by {|hash| hash[hash_key]}.reverse
  end

  def parse_and_sort
    find_id.each do |id|
      begin
        target_data(id)
      rescue 
        next
      end
    end
    sort_followers(info_array, :followers_count)
  end

  def find_photo_location(id)
    locations = []
    results = Instagram.user_recent_media(id)
    3.times do |i|
      locations << {:latitude => results[i].location[:latitude], :longitude => results[i].location[:longitude]}
    end
    locations
  end

  def geo_details(locations)
    geodetails = []
    locations.each do |element|
      geodetails << Geocoder.search("#{element[:latitude]}, #{element[:longitude]}")
    end
    geodetails
  end 

  def location_parse(geo_details)
    geo_details.map { |info| info[0].data["formatted_address"]}
  end

  def address_regex(addresses)
    regex = /^.+,\s([\w\s]*,\s[A-Z][A-Z])\s.*$/
    addresses.map { |address| address.match(regex)[1] }
  end

  def get_location(id)
    locations = find_photo_location(id)
    geo_details = geo_details(locations)
    location_parse = location_parse(geo_details)
    address_regex = address_regex(location_parse)
  end
end