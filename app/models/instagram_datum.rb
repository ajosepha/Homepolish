class InstagramDatum < ActiveRecord::Base

  belongs_to :user
  attr_accessible :name, :username, :bio, :followers_count, :instagram_id, :location, :id
  validates_uniqueness_of :username, scope: :user_id


  def store_followers(current_user)
    InstagramUser.new(current_user)
    @data = Instagram.user_followed_by(current_user.authentications.find_by_provider("instagram").uid, :count => -1)
    save_followers(current_user)
  end

  def make_array
    array = []
    @data.each do |user|
      array << {
        :instagram_id => user["id"],
        :username => user["username"],
        :bio => user["bio"],
        :name => user["full_name"]}
    end
    array
  end


  def save_followers(current_user)
    make_array.each do |element|
      follower = InstagramDatum.new(element)
      follower.user_id = current_user.id
      follower.save
    end
  end


  def find_private
    @private = InstagramDatum.where(followers_count: -1)
  end

  def find_followers_count
    @followers = InstagramDatum.where("followers_count IS NOT NULL")
  end

  def find_followers
    InstagramInitialize.new
    @update = InstagramDatum.where(followers_count: nil)
    @update.each_with_index do |person, i|
      break if i > 100
      begin
        person_id = person.instagram_id
        followers = Instagram.user(person_id)
        person.followers_count = followers["counts"]["followed_by"]
        person.save
      rescue
        person.followers_count = -1
        person.save
        next     
      end
    end
  end


  def make_array
    array = []
    @data.each do |user|
      array << {
        :instagram_id => user["id"],
        :username => user["username"],
        :bio => user["bio"],
        :name => user["full_name"]}
    end
    array
  end

  def self.save_data
    array = make_array
    array.each do |element|
      info = InstagramDatum.new(element)
      info.user_id = current_user.id
      info.save
    end
  end


end

# @data = Instagram.user_followed_by(9620227, {:count => -1})



