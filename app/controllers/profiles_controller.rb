# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  layout 'onboarding-layout', only: %i[onboarding create_onboarding]

  def new
    @profile = @user.build_profile
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = 'Your Profile was successfully created.'
      redirect_to admin_profile_path
    else
      respond_to do |format|
        format.js { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @profile = @user.profile
    respond_to do |format|
      format.js
    end
  end

  def update
    @profile = @user.profile
    if @profile.update(profile_params)
      flash[:success] = 'Your Profile was successfully updated.'
      redirect_to admin_profile_path
    else
      respond_to do |format|
        format.js { render :edit }
      end
    end
  end

  def onboarding
    if @user.profile.present?
      redirect_to admin_profile_url
    else
      @profile = @user.build_profile
    end
  end

  def create_onboarding

    if @user.profile.present?
      redirect_to admin_profile_url
    else
      @profile = @user.build_profile(profile_params)
      if @profile.save
        flash[:success] = 'Your Profile was successfully created.'
        redirect_to admin_profile_path
      else
        flash[:error] = 'Something went wrong.'
        render 'profiles/onboarding'
      end
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :title, :company, :phone, :address, :city, :state,
                                    :zip_code, :avatar)
  end
end
