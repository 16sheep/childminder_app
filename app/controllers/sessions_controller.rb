class SessionsController < ApplicationController
    #homepage
    def index
      #check if user is logged in and assign user
      #if not then have user nil
    end

    def new
      # renders login form from views/sessions/new
    end

    def create
      #Gets params from the login form, checks if that user exists,
      #authenticates the existing user and assings
      # found user's id to the session hash
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        redirect_to "/login"
      end
    end

    #logout
    def destroy
      #Removes :user_id from the session hash.
      session[:user_id] = nil
      redirect_to root_path
    end
end
