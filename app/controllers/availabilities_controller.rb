class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [ :show, :update, :edit, :destroy, :booking]
  before_action :authorize_user_objects, only: [:show, :update, :edit, :delete, :booking, :create, :new]

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
    if params[:availability][:time_from] == "" || params[:availability][:time_until] == ""
      @availability = Availability.new
      flash[:notice] = "Please enter correct times"
      return redirect_to new_user_availability_url(current_user)
    end
    availability = Availability.new(availability_params)
      posting = Posting.find_or_initialize_by(user_id: params[:user_id], school_id: params[:availability][:school_id])
      posting.availabilities << availability
      posting.save
      availability.posting = posting
      if availability.time_from < Time.now || availability.time_from > availability.time_until
        flash[:notice] = "Time can not be in the past"
        return redirect_to new_user_availability_url(current_user)
      end
      if availability.valid?
        availability.save
        flash[:notice] = "New availability was created"
        redirect_to user_availabilities_url(availability.user.id)
      else
        flash[:errors] = availability.errors.full_messages
        redirect_to new_user_availability_url(current_user)
      end
  end

  def destroy
    @availability.destroy
    redirect_to user_availabilities_path(current_user.id)
  end

  private
  def availability_params

    date_array = params[:date].values.map {|v| v.to_i}
    params[:availability][:time_from] = Time.new(date_array[2], date_array[1], date_array[0], params[:availability][:time_from].to_time.hour, params[:availability][:time_from].to_time.min)
    params[:availability][:time_until] = Time.new(date_array[2], date_array[1], date_array[0], params[:availability][:time_until].to_time.hour, params[:availability][:time_until].to_time.min)
    params.require(:availability).permit(:time_until, :time_from, :number_of_children, :cost_per_hour)
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
