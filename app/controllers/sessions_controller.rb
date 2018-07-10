class SessionsController < ApplicationController

    #homepage
    def index
        #check if user is logged in and assign user
        #if not then have user nil
    end

    def new
        #login
    end
    #login page
    def create
        #where session
        @user = User.find_by(username: params[:username])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
    end

    #logout
    def destroy
        session[:user_id]
        redirect_to root_path
    end

end
