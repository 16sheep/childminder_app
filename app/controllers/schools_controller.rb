class SchoolsController < ApplicationController
  def show
    @school = School.find(params:id)
  end

  def index
    @schools = School.all
  end
end
