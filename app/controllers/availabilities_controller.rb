class AvailabilitiesController < ApplicationController


  def show
    @availability = Availability.find(params[:id])
  end

  def new
    @availability = Availability.new
  end

  def create
    availability = Availability.create(availability_params)
    posting = Posting.create(:user_id => params[:user_id], :school_id => params[:availability][:school_id])
    posting.availabilities << availability
    posting.save
    redirect_to user_availability_url(posting.user)
  end

  private

  def availability_params
    params.require(:availability).permit(:time_from, :time_until, :number_of_children, :cost_per_hour)
  end

end
