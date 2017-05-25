# for taken medicine record
class Record < ApplicationRecord
  belongs_to :users
  has_many :notifications
  class << self
    def create_after_medicine(params)
      notify_id = params[:notification_id].to_i
      create!(
        user_id:          params[:user_id].to_i,
        notification_id:  notify_id,
        medicine_id:      params[:medicine_id].to_i
      )
      Notification.find(notify_id).update(taken_medicine: true)
    end
  end # class
end
