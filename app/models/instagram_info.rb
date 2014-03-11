class InstagramInfo < ActiveRecord::Base

  attr_accessible :bio, :followers_count, :location

  def initialize
    Instagram.configure do |config|
      config.client_id = "73c57238ee7a4998818a4bb43e3aa369"
      config.client_secret = "3e9d04b20ad34cfea76b7a8fd5797308"
      config.access_token = "225440768.2485542.3da25a35bab5486f831de5377915f66f"
    end
  end

  def find_followers_count
    @update = InstagramDatum.where(followers_count: nil)
  end


  def find_followers
    find_followers_count
    @update.each_with_index do |person, i|
      break if i > 50
       begin
        id = person.instagram_id
        followers = Instagram.user(id)
        person.followers_count = followers["counts"]["followed_by"]
        person.save
      rescue
        person.delete
        next     
      end
    end
  end
end