class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :destroy]

  def show
    @children = @user.children
  end

  def edit
  end

  def new
    @user = User.new
    3.times do
      children = @user.children.build
    end
  end

  def user_availabilities
    @user = User.find(params[:user_id])

  end

  def create
    @user = User.create(user_params)
    @user.password = (params[:password])
    @user.save
    redirect_to @user
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :children_attributes => [:name, :age], :session_ids => [], :session_booking_ids => [])
  end

end
