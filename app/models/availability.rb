class Availability < ApplicationRecord
  belongs_to :posting

  def school_id=(school_id)
    @school_id = school_id
  end

  def school_id
    @school_id
  end

  def user_id=(user_id)
    @user_id
  end

  def user_id
    @user_id
  end


end
