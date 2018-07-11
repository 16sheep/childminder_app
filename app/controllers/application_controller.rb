class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :user_logged_in#:require_login
    #before_action :user_logged_in

    def current_user
      #Identifies and returns the user from session hash
      if(session[:user_id] && session[:user_id] != nil)
          return User.find(session[:user_id])
      else
          nil
      end
    end

    def authorize_user
      if !session[:user_id] || current_user.id != @user.id
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end

    def authorize_user_child
      if !session[:user_id] || current_user.id != @child.user_id
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end

    def authorize_user_availability
      if !session[:user_id] || current_user.id != @availability.user.id
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end

    def authorize_user_bookings
      if !session[:user_id] || current_user.id != @session_booking.user_id
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end




    def require_login
      if(!session.include?(:user_id))
          redirect_to '/'
      end
    end

    def user_logged_in
       !!session[:user_id]
    end
end
