class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])   
        # render plain: user.activation_digest    
        # if user && !user.activated && user.authenticated?(:activation, params[:id])
        if user 
            user.activate
            log_in user
            flash[:success] = "Account activated !"
            redirect_to root_path
        else
            flash[:danger] = "Invalid activation link"
            render plain: flash.inspect
            # redirect_to '/'
        end
     end
end
