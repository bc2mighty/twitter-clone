class LandingController < ApplicationController
  before_action :authenticate, only: [:index]

  def index
    @user = User.find(session[:user_id])
    # render plain: @user.inspect
    # @message = Message.new
    @followers = []
    if @user.followers.length
    	@followers = @user.followers.pluck(:follower_id)
    end
    @tweet = Tweet.new
    @tweets = Tweet.all.reverse
    # render plain: @tweets[0].user.followers.pluck(:follower_id).inspect
  end
end
