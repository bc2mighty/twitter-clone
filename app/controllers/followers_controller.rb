class FollowersController < ApplicationController
    def follow
        #Currently signed in user
        @user = User.find(session[:user_id])

        #user gotten from the url above
        @user_to_follow = User.find_by username: params[:username]
        if !@user_to_follow.nil?
            @already_following = Follower.where("follower_id = ? AND user_string_id = ?", @user.user_id, @user_to_follow.user_id)
            
            # render plain: @user.inspect
            if @already_following.size and @user_to_follow.user_id != @user.user_id
                @follower = Follower.new
                @follower.following_id = SecureRandom.uuid
                @follower.follower_id = @user.user_id
                @follower.user_string_id = @user_to_follow.user_id
                @follower.user_id = @user_to_follow.id
                
                if @follower.save
                    flash[:success] = "You are now following #{@user_to_follow.username}"
                else
                    flash[:error] = "Could not Follow #{@user_to_follow.username} Successfully"
                end
            elsif @user_to_follow.user_id == @user.user_id
                flash[:error] = "You can not follow yourself #{@user_to_follow.username}"
            else
                flash[:error] = "You are already following #{@user_to_follow.username}"
            end
            redirect_to "/#{@user_to_follow.username}"
        else
            render plain: "User not found"
        end
    end

    def unfollow
        #Currently signed in user
        @user = User.find(session[:user_id])

        #user gotten from the url above
        @user_to_follow = User.find_by username: params[:username]

        if !@user_to_follow.nil?
            @already_following = Follower.find_by follower_id: @user.user_id, user_string_id: @user_to_follow.user_id
            
            if !@already_following.nil?
                Follower.delete_by(follower_id: @user.user_id, user_string_id: @user_to_follow.user_id)
                flash[:error] = "You have successfully Unfollowed #{@user_to_follow.username}"
            else
                flash[:error] = "You are not following #{@user_to_follow.username} yet."
            end
            redirect_to "/#{@user_to_follow.username}"
        else
            render plain: "User not found"
        end
    end
end
