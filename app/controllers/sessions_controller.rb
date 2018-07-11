class SessionsController < ApplicationController
    #homepage
    def index
      #check if user is logged in and assign user
      #if not then have user nil
      @schools = School.all
    end

    def new
      # renders login form from views/sessions/new
      if(user_logged_in)
        redirect_to "/users/#{current_user.id}"
      end
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

    def search
      school_id = params[:school_id]
      date_array = params[:date].values.map {|v| v.to_i}
      date = Date.new(date_array[2], date_array[1], date_array[0])

      @search_date = date.strftime("%A, %d-%B-%Y")

      @availabilities = Availability.all.select do |availability|
          (availability.time_from.to_date >= date) && (availability.time_until <= (date + 1))
      end
    end
end
