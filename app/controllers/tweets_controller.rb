class TweetsController < ApplicationController
    def create
        #Currently signed in user
        @user = User.find(session[:user_id])

        #Followers from users
        # @followers = @user.followers.pluck(:follower_id)
        @followers = @user.followers.pluck(:follower_id)

        @tweet = Tweet.new(tweet_params)
        @tweet[:user_id] = @user.id
        @tweet[:user_string_id] = @user.user_id
        @tweet[:tweeter_id] = SecureRandom.uuid
        # render plain: params[:tweet][:followers].inspect
        if @tweet.save
            ActionCable.server.broadcast 'tweet_channel', time_sent: @tweet.created_at, content: @tweet, tweet_owner: @tweet.user_string_id, followers: @followers, current_user: @user.user_id, user: @user
        else
            render plain: "Nah Bruh"
        end
    end

    private
        def tweet_params
            params.require(:tweet).permit(:tweet)
        end
end
