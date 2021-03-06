class SessionBookingsController < ApplicationController

  before_action :set_booking, only: [:show, :destroy, :edit, :update]
  before_action :require_login, only: [:index, :show, :new, :create, :destroy]
  before_action :authorize_user_objects, only:[:index, :show, :new, :create, :destroy]

  def index
    @bookings = SessionBooking.all.select do |session_booking|
      session_booking.user_id == current_user.id
    end
  end

  def show
    if @booking == nil
      flash[:notice] = "The parent and booking don't match"
      redirect_to "/"
    end
  end

  def new
    redirect_to '/'
  end

  def create
    availability = Availability.find(params[:availability_id].to_i)
    max_num_children = availability.number_of_children
    if params[:session_bookings][:children_ids].length - 1 <= max_num_children
      params[:session_bookings][:children_ids].each do |child_id|
        if child_id != ""
          booking = SessionBooking.new(user_id: params[:user_id], availability_id: params[:availability_id], child_id: child_id)
          max_num_children -= 1
          if(booking.valid?)
            availability.update(number_of_children: max_num_children)
            booking.save
          end
        end
      end
      flash[:notice] = "#{SessionBooking.last.child.name} has been booked with #{SessionBooking.last.availability.user.name} on #{SessionBooking.last.availability.time_from.strftime("%A, %d %B")}"
      redirect_to user_session_bookings_path
    else
      flash[:notice] = "There is not enough spaces"
      redirect_to user_availability_path(availability.user.id, availability.id)
    end
  end

  def destroy
    a = Availability.find(@booking.availability_id)
    num_children = a.number_of_children
    a.update(:number_of_children => num_children + 1)
    @booking.destroy
    flash[:notice] = "Booking cancelled"
    redirect_to user_session_bookings_path
  end

  private

  def set_booking
    booking = SessionBooking.find(params[:id])
    if(booking.user_id == current_user.id)
      @booking = booking
    else
      redirect_to '/'
    end
  end

  def session_booking_params
    params.require(:session_booking).permit(:children_ids => [])
  end

end
