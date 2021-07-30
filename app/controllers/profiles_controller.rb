# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:success] = 'Your Profile was successfully created'
      redirect_to admin_profile_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.reload_profile
    if @profile.update(profile_params)
      flash[:success] = 'Your Profile was successfully updated'
      redirect_to admin_profile_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to admin_profile_path
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :title, :company, :phone, :address, :city, :state,
                                    :zip_code)
  end
end
