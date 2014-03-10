class InstagramDatum < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :username, :bio, :followers_count, :instagram_id, :location
  validates_uniqueness_of :username, scope: :user_id

  # def create_with_instagram(current_user)
  #   instagram_parser = InstagramParser.new(current_user)
  #   data = instagram_parser.parse_and_sort
  #   data.each do |datum|
  #     d = InstagramDatum.new(datum)
  #     d.user_id = current_user.id
  #     d.save
  #   end
  # end

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
      dumb.user_id = User.last.id
      dumb.save
    end
  end

end

# @test = Instagram.user_followed_by(9620227, {:count => -1})



