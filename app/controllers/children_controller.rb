class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :destroy, :update]
  #before_action :authorize_user, only: [:show, :edit, :destroy, :update, :new, :create]

  def show
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
    @child = Child.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:name, :age, :school_id)
  end
end
