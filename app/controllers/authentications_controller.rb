class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid_and_token_and_secret_and_nickname(
      auth['provider'], auth['uid'], 
      auth["credentials"]["token"],
      auth["credentials"]["secret"],
      auth["info"]["nickname"])

    if auth['provider'].downcase == "twitter"
      @a = TwitterDatum.new
      @a.create_with_twitter(current_user)
    else
      @b = InstagramDatum.new
      @b.store_followers(current_user)
    end
    flash[:notice] = "#{auth['provider'].to_s.capitalize} authentication successful"
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully removed authentication."
  end
end
