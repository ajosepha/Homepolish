
class TwitterDatum < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :username, :bio, :location, :followers_count, :user_id
  validates_uniqueness_of :username, scope: :user_id


  def save_twitter(current_user)
    begin
    a = TwitterInitialize.new(current_user)
    array = a.find_followers
    array.each do |person|
      d = TwitterDatum.new(person)
      d.user_id = current_user.id
      d.save 
    end
    rescue
      raise 'An error has happened'
    end
  end

end