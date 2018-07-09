class AvailabilitiesController < ApplicationController


  def show
    @availability = Availability.find(params[:id])
  end

  def new
    @availability = Availability.new
  end

end
