class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    helper_method :current_user, :require_login

    before_action :user_logged_in

    def current_user
        if(session[:user_id] && session[:user_id] != nil)
            return User.find(session[:user_id])
        else
            nil
        end
    end

    def require_login
        if(!session.include?(:user_id))
            redirect_to '/'
        end
    end

    def user_logged_in
        return !!session[:user_id]
    end
end
