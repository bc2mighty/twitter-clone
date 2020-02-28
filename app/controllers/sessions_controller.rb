class SessionsController < ApplicationController
    def new
    end

    def create
       
        @user = User.find_by(email: permit[:email].downcase)
        if @user && @user.authenticate(permit[:password])
            if @user.activated? 
                log_in @user
                params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
                redirect_to '/'
            else
                message = "Account not activated. "
                message += "Check your email for the activation link"
                flash[:warning] = message
                redirect_to '/login'                
            end
        else
            flash.now[:errors] = 'Invalid Email or password'
            render 'new'
        end
    end

    def loggedout
        # render plain: "Logot"
    end

    def logout
        log_out if logged_in?
        redirect_to '/loggedout'
    end

    def permit
        params.require(:session).permit(:email, :password, :remember_me)
    end
end
