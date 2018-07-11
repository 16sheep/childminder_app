class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :destroy]

  def show
    if session[:user_id] == @user.id
      @children = @user.children
    else
      flash[:notice] = "You are not authorized to view this page"
      redirect_to '/'
    end
  end

  def edit

  end

  def new
    if !session[:user_id]
      @user = User.new
    else
      redirect_to '/'
    end
  end

  def user_availabilities
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.create(user_params)
    @user.save
    redirect_to '/login'
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to @user
  end

  def destroy
  end

  private
  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
