class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :destroy, :update]
  before_action :authorize_user_objects, only: [:show, :edit, :destroy, :update, :new, :create]

  def show
    if set_child == nil
      flash[:notice] = "The child and parent don't match"
      redirect_to '/'
    end
    @bookings = Availability.all.select do |availability|
      if availability.session_bookings.length > 0
        availability.session_bookings.select do |booking|
          booking.child_id == @child.id
        end
      end
    end
  end



  def edit
  end

  def update
    @child.update(child_params)
    if @child.valid?
      @child.save
      flash[:notice] = "Updated successfully"
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = @child.errors.full_messages
      redirect_to edit_user_child_path(current_user)
    end
  end

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.user = current_user
    if @child.valid?
      @child.save
      flash[:notice] = "New child was added"
      redirect_to "/users/#{@child.user_id}"
    else
      flash[:errors] = @child.errors.full_messages
      redirect_to new_user_child_path(current_user)
    end
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
