class RecordsController < ApplicationController
  def create
    message = 
      if check_parameter('create', params)
        params[:user_id] = current_user.id
        Record.create_with(params)
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
      params[:medicine_id] && params[:notification_id] ? true : false
    end
  end
end