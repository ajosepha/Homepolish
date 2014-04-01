# require 'twitter'

#   def initialize
#     @client = Twitter::REST::Client.new do |config|
#       config.consumer_key        =  "tZ9FURAKtzwCtcpQuZhJg"
#       config.consumer_secret     = "k0EgjafMQAJ9Z5jVVRQy4BhcjfhrIVFRHKFqeddg"
#       config.access_token = '89102612-HfigwabbsPGT0axMyppvpsnq47lLkeXZxfoNnv9Ow'
#       config.access_token_secret = 'CLtUHiEeZYAXjOPBB7BEIWqzSRn6sXkHApCGi7IUA8KMT'
#     end
#   end

#  @client = Twitter::REST::Client.new do |config|
  # config.consumer_key        = "hM8HnQ75aT8LZqAuJUI73bnT9"
  #     config.consumer_secret     = "5UtJWmyS7VKR2lUa0TpE3mCprYBfmxEI1dzJlX6IVaAAafQOMc"
  #     config.access_token        = "1326092978-eLe8nlYO85MknA1GIVYqc3OfqbRnNtL2q2DXDMI"
  #     config.access_token_secret = "4N0ksHX8ZxnOzkOGNBVO9eTFgSAyAtcFAwxNFLf6dGPft"
# end


#   def find_followers
#     #returns all followers
#     @client.followers
#   end



require 'rubygems'
require 'twitter'
 
# see https://github.com/sferik/twitter
 
def twitter_client
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        =  "tZ9FURAKtzwCtcpQuZhJg"
    config.consumer_secret     = "k0EgjafMQAJ9Z5jVVRQy4BhcjfhrIVFRHKFqeddg"
    config.access_token = '89102612-HfigwabbsPGT0axMyppvpsnq47lLkeXZxfoNnv9Ow'
    config.access_token_secret = 'CLtUHiEeZYAXjOPBB7BEIWqzSRn6sXkHApCGi7IUA8KMT'
  end
end

def tw_follower_ids
  @client.follower_ids.to_a
  rescue Twitter::Error::TooManyRequests => error
    p error
    p 'tw_follower_ids sleep ' + error.rate_limit.reset_in.to_s
    sleep error.rate_limit.reset_in
  retry
end
