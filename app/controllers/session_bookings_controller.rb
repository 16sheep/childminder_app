class SessionBookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]

  def index
    @bookings = SessionBooking.all
  end

  def show
  end

  def new
    @booking = SessionBooking.new
  end
      
  def create
    params[:session_bookings][:children_ids].each do |child_id|
      if !child_id.empty?
        SessionBooking.create(user_id: current_user.id, availability_id: params[:availability_id], child_id: child_id)
      end
    end
    redirect_to user_session_bookings_path
  end

  def destroy
    @booking.destroy
  end

  private

  def set_booking
    @booking = SessionBooking.find(params[:id])
  end

  def session_booking_params
    params.require(:session_booking).permit(:children_ids => [])
  end

end
