class ChildrenController < ApplicationController
  before_action :set_child

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:name, :age, :parent_id)
  end
end
