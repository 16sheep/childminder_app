class SessionBookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy, :edit, :update]
  before_action :authorize_user_objects, only:[:index, :show, :new, :create, :destroy]

  def index
    @bookings = SessionBooking.all
  end

  def show
    if @booking = nil
      flash[:notice] = "The parent and booking don't match"
      redirect_to "/"
    end
  end

  def new
    @booking = SessionBooking.new
  end

  def create
    availability = Availability.find(params[:availability_id].to_i)
    num_children = availability.number_of_children
    if num_children >= params[:session_bookings][:children_ids].length && num_children > 0
      params[:session_bookings][:children_ids].each do |child_id|
        if !child_id.empty?
          booking = SessionBooking.create(user_id: current_user.id, availability_id: params[:availability_id], child_id: child_id)
          num_children -= 1
          availability.update(:number_of_children => num_children)
        end
      end
    redirect_to user_session_bookings_path
    else
      flash[:notices] = "There is not enough spaces"
      redirect_to user_availability_path(availability.user.id, availability.id)
    end
  end

  def destroy
    a = Availability.find(@booking.availablity_id)
    num_children = a.number_of_children
    a.update(:number_of_children => num_children + 1)
    @booking.destroy
  end

  private

  def set_booking
    bookings = SessionBooking.all.select do |b|
      b.user_id == params[:user_id].to_i
    end
    if bookings.include?(SessionBooking.find(params[:id]))
      @booking = SessionBooking.find(params[:id])
    else
      nil
    end
  end

  def set_user
    @user = @booking.user
  end

  def session_booking_params
    params.require(:session_booking).permit(:children_ids => [])
  end

end
