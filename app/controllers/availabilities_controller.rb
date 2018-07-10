class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :update, :edit, :delete, :booking]


  def show
    @booking = Booking.new
  end

  def booking
    @booking = Booking.create(user_id: current_user.id, availability_id: @availability.id, child_id: children_ids[])
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
    posting = Posting.find_or_create_by(user_id: params[:user_id], school_id: params[:school_id])
    posting.availabilities << availability
    posting.save
    availability.posting = posting
    availability.save
    redirect_to user_availabilities_url(availability)
  end
 #Get posting to
  private

  def availability_params
    params.require(:availability).permit(:time_from, :time_until, :number_of_children, :cost_per_hour)
  end

  def set_availability
    @availability = Availability.find(params[:id])
  end
end
