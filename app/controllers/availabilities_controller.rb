class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [ :show, :update, :edit, :destroy, :booking]
  before_action :authorize_user_objects, only: [:update, :edit, :delete, :booking, :create, :new]

  def index
    @available_dates = Availability.all.select do |availability|
      if availability.user != nil
        availability.user.id = params[:user_id].to_i
      end
    end
  end

  def show
    if @availability == nil
      flash[:notice] = "The childminder and availability don't match"
      redirect_to '/'
    end
  end

  def edit
  end

  def update
    @availability.update(availability_params)
    @availability.save
    redirect_to user_availability_url(@availability)
  end

  def new
    @availability = Availability.new
  end

  def create
    availability = Availability.create(availability_params)
    posting = Posting.find_or_create_by(user_id: params[:user_id], school_id: params[:availability][:school_id])
    posting.availabilities << availability
    posting.save
    availability.posting = posting
    availability.save
    redirect_to user_availabilities_url(availability.user.id)
  end

  def destroy
    @availability.destroy
    redirect_to user_availabilities_path(current_user.id)
  end

  private
  def availability_params
    params.require(:availability).permit(:time_from, :time_until, :number_of_children, :cost_per_hour)
  end

  def set_availability
    availabilities = Availability.all.select do |a|
      if(a.user != nil)
        params[:user_id].to_i == a.user.id
      end
    end
    if availabilities.include?(Availability.find(params[:id]))
      @availability = Availability.find(params[:id])
    else
      nil
    end
  end

end
