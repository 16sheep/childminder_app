class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [ :show, :update, :edit, :destroy, :booking]
  before_action :authorize_user_objects, only: [:update, :edit, :delete, :booking, :create, :new]

  def index
    @available_dates = Availability.all.select do |availability|
        availability.user.id == current_user.id
    end
  end

  def show
    if @availability == nil
      flash[:notice] = "The childminder and availability don't match"
      redirect_to '/'
    end
    if @availability.session_bookings
      @bookings = @availability.session_bookings
    end
  end

  def edit
  end

  def update
    @availability.update(availability_params)
    @availability.save
    flash[:notice] = "Availability was updated"
    redirect_to user_availability_url(@availability)
  end

  def new
    @availability = Availability.new
  end

  def create
    availability = Availability.new(availability_params)
    posting = Posting.find_or_initialize_by(user_id: params[:user_id], school_id: params[:availability][:school_id])
    posting.availabilities << availability
    posting.save
    availability.posting = posting
    availability.save
    flash[:notice] = "New availability was created"
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
    availability = Availability.find(params[:id])
    if(availability.user.id == current_user.id)
      @availability = availability

    else
      nil
    end
  end

end
