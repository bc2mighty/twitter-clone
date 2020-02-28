class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:index, :show ]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless FILL_IN
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user[:user_id] = SecureRandom.uuid

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        format.html { redirect_to @user, notice: 'User was successfully created, Please check your email to activate your account.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    def profile
        # Currently signed in user
        @user = User.find(session[:user_id])

        #user gotten from the url above
        @user_url_details = User.find_by username: params[:username]

        if @user_url_details.nil? == true
          redirect_to root_path
        else
          @title = "#{@user_url_details.username} Profile"
          @followers = []

          if @user_url_details.followers.length
            @followers = @user_url_details.followers.pluck(:follower_id)
          end
          @followings = Follower.where("user_string_id = ?", @user_url_details.user_id)
          if @followings.length
            @followings = @followings.pluck(:follower_id)
          end
          @tweets = Tweet.where("user_string_id = ?", @user_url_details.user_id)

          # render plain: @followers.inspect
        end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :username, :email, :password)
    end
end
