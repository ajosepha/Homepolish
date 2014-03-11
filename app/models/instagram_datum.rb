class InstagramDatum < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :username, :bio, :followers_count, :instagram_id, :location
  validates_uniqueness_of :username, scope: :user_id

  def find_followers_count
    @update = InstagramDatum.where(followers_count: nil)
  end


  def find_followers
    InstagramInitialize.new
    find_followers_count
    @update.each_with_index do |person, i|
      break if i > 4000
       begin
        id = person.instagram_id
        followers = Instagram.user(id)
        person.followers_count = followers["counts"]["followed_by"]
        person.save
      rescue
        person.followers_count = 0
        next     
      end
    end
  end


  def make_array
    array = []
    @test.each do |user|
      array << {
        :instagram_id => user["id"],
        :username => user["username"],
        :bio => user["bio"],
        :name => user["full_name"]}
    end
    array
  end

  def self.save_dummy
    data = make_array
    array.each do |element|
      dumb = InstagramDatum.new(element)
      dumb.user_id = User.first.id
      dumb.save
    end
  end

end

# @test = Instagram.user_followed_by(9620227, {:count => -1})



