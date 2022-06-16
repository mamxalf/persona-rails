class ApplicationController < ActionController::Base
  before_action :authenticate_auth!

  protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
    '/dashboard/index'
  end

  def after_sign_out_path_for(scope)
    # return the path based on scope
    '/auths/sign_in'
  end

  def after_sign_up_path_for(resource)
    # return the path based on resource
    '/dashboard/index'
  end

  def response_success(object)
    object
  end

  def response_failure!(object, message, flash_type: :notice)
    if message.class == String
      flash[flash_type] = message
    else
      flash[flash_type] = message.as_json['active_model_errors']
    end
  end
end
