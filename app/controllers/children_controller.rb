class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :destroy, :update]
  before_action :authorize_user_objects, only: [:show, :edit, :destroy, :update, :new, :create]

  def show
    if set_child == nil
      flash[:notice] = "The child and parent don't match"
      redirect_to '/'
    end
  end

  def edit
  end

  def update
    @child.update(child_params)
    child.save
    redirect_to "/users/#{child.parent_id}"
  end

  def new
    @child = Child.new
  end

  def create
    child = Child.create(child_params)
    child.user = current_user
    child.save
    redirect_to "/users/#{child.user_id}"
  end

  def destroy
    @child.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def set_child
    children = Child.all.select do |c|
      c.user_id == params[:user_id].to_i
    end
    if children.include?(Child.find(params[:id]))
      @child = Child.find(params[:id])
    else
      nil
    end
  end

  def set_user
    @user = @child.user
  end

  def child_params
    params.require(:child).permit(:name, :age, :school_id)
  end
end
