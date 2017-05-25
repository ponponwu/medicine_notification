class NotificationsController < ApplicationController
  # not deal with user part, assume all users are logged in
  def create
    message = 
      if check_parameter('create', params)
        params[:user_id] = current_user.id
        Notification.create_with(params)
        "Create Success!"
      else
        "Error!"
      end
    render json: {
      message: message
    }
  end


  private

  def check_parameter(action, params)
    case action
    when 'create'
      params[:medicine_id] && params[:wday] && params[:medicine_time] && params[:medicine_pill_num] ? true : false
    end
  end

end