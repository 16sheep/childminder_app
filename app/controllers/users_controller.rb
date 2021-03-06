class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :destroy, :update]
  before_action :require_login, only: [:show, :edit, :update, :delete]
  before_action :authorize_user, only:[:show, :edit, :update, :delete]
  def show
    @children = @user.children
  end

  def edit
  end

  def data
    @children = Child.all
    @users = User.all
    @bookings = SessionBooking.all
   "/data"
  end

  def new
    if !user_logged_in
      @user = User.new
    else
      redirect_to '/'
    end
  end

  def user_availabilities
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      flash[:notice] = "Your account was created successfully, you can log in"
      redirect_to '/login'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/signup'
    end
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to @user
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account deleted"
    redirect_to '/'
  end

  private
  def set_user
      @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
