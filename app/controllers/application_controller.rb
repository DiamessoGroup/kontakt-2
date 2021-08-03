class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    admin_profile_url
  end

  private

  def set_user
    @user = current_user
  end
end
