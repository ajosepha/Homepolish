class InstagramTest 
  Instagram.configure do |config|
      config.client_id = "73c57238ee7a4998818a4bb43e3aa369"
      config.client_secret = "3e9d04b20ad34cfea76b7a8fd5797308"
      config.access_token = "225440768.2485542.3da25a35bab5486f831de5377915f66f"
    end
  end

  def self.create_with_instagram
    data = Instagram.user_followed_by
    data.each do |element|
      d = InstagramDatum.new(element)
      d.save
    end
  end
end