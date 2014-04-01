# require 'ap'
require 'twitter'

class TwitterParser 


  attr_accessor :client, :info_array, :user_obj

  def initialize(user_obj)
    @user_obj = user_obj
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user_obj.authentications.find_by_provider("twitter").token
      config.access_token_secret = user_obj.authentications.find_by_provider("twitter").secret
    end
    @info_array = []
  end

  def find_followers
     while i < 20
    @client.followers[i] do |person|
      @info_array << { :name => person.name,
      :username => person.username, 
      :bio => person.description,
      :followers_count => person.followers_count,
      :location => person.location }
    end
  end


end