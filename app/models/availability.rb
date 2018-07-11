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

  def user
    if(self.posting && self.posting.user_id)
      user = User.find(self.posting.user_id)
    else
      nil
    end
  end

end
