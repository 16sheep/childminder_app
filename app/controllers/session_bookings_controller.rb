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

  def create(session_booking_params)
      
  end

  def destroy
    @booking.destroy
  end

  private

  def set_booking
    @booking = SessionBooking.find(params[:id])
  end

  def session_booking_params
    params.require(:session_booking).permit(:child_id, :user_id, :availability_id)
  end

end
