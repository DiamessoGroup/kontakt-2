# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    @profile = current_user.build_profile
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:success] = 'Your Profile was successfully created'
      redirect_to admin_profile_path
    else
      flash[:error] = 'Something went wrong'
      respond_to do |format|
        format.js { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @profile = current_user.profile
    respond_to do |format|
      format.js
    end
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = 'Your Profile was successfully updated'
      redirect_to admin_profile_path
    else
      flash.now[:error] = 'Something went wrong'
      respond_to do |format|
        format.js { render :edit }
      end
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :title, :company, :phone, :address, :city, :state,
                                    :zip_code)
  end
end
