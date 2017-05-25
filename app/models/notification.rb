# notify (user, medicine, time) as PK
class Notification < ApplicationRecord
  belongs_to :users
  class << self
    def create_with(params)
      create!(
        user_id:            params[:user_id],
        medicine_id:        params[:medicine_id],
        wday:               params[:wday],
        medicine_time:      params[:medicine_time],
        medicine_pill_num:  params[:medicine_pill_num]
      )
    end
  end 
end
