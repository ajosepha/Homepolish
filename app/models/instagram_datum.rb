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



