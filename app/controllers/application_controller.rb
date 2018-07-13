class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_user, :require_login, :user_logged_in

    def current_user
      #Identifies and returns the user from session hash
      if(session[:user_id] && session[:user_id] != nil)
          User.find(session[:user_id])
      else
          nil
      end
    end

    #todo: Check if the user is logged in user
    def authorize_user
      if !user_logged_in || current_user.id != params[:id].to_i
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end

    def authorize_user_objects
      if !user_logged_in || current_user.id != params[:user_id].to_i
        flash[:notice] = "You are not authorized to view this page"
        redirect_to "/"
      end
    end

    def require_login
      if (!user_logged_in)
        flash[:notice] = "You need to login to to view that page"
        redirect_to '/login'
      end
    end

    def user_logged_in
       !!session[:user_id]
    end
end
