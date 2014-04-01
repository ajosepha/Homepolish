class StaticPagesController < ApplicationController
  def home
  end

  def top_followers
    @twitteruser = current_user
    twitter_followers = @twitteruser.twitter_data.order("followers_count DESC")
    @twitter_parsed = twitter_followers.page(params[:page]).per(10)
    @loop = @twitter_parsed.length
    instauser = current_user
    instagram_followers = instauser.instagram_data.order("followers_count DESC")
    @instagram_parsed = instagram_followers.page(params[:page]).per(10)
  end

  def create
    @user = current_user
  end
end
