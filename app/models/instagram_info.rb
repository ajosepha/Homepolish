class InstagramInfo < ActiveRecord::Base

  attr_accessible :bio, :followers_count, :location

  def find_followers_count
    @update = InstagramDatum.where(followers_count = nil)
  end


  def find_followers(id)
    @update.each do |person|
       begin
        id = person.instagram_id
        followers = Instagram.user(id)
        person.followers_count = followers["counts"]["followed_by"]
        person.save
        puts person
      rescue
        person.delete
        next     
      end
    end
  end


  
end