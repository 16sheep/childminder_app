class SessionBookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  before_action :require_login, only: [:index, :show, :new, :create, :destroy]

  def index
    @bookings = SessionBooking.all.select do |session_booking|
      session_booking.user_id == current_user.id
    end #TODO grab the users sessionbookings
  end

  def show

  end

  def new
    redirect_to '/'
  end

  def create

    params[:session_bookings][:children_ids].each do |child_id|
      if !child_id.empty?
        s = SessionBooking.create(user_id: current_user.id, availability_id: params[:availability_id], child_id: child_id)
        byebug
      end
    end

    redirect_to user_session_bookings_path
  end

  def destroy
    @booking.destroy
  end

  private

  def set_booking
    bookings = SessionBooking.all.select do |b|
      b.user_id == current_user.id
    end
    if bookings.include?(SessionBooking.find(params[:id]))
      @booking = SessionBooking.find(params[:id])
    else
      nil
    end
  end

  def session_booking_params
    params.require(:session_booking).permit(:children_ids => [])
  end

end
