class AvailabilitiesController < ApplicationController
  def show
    @availability = Availability.find(params[:id])
  end

end
