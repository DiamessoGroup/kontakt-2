# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @notes = @user.notes
  end

  def new
    @note = @user.notes.build
  end

  def create
    @note = @user.notes.build(note_params)
    if @note.save
      flash[:success] = 'Your Note successfully created.'
      redirect_to admin_profile_path
    else
      flash.now[:error] = 'Something went wrong. Your Note could not be saved.'
      render 'admin/profile', layout: 'admin-layout'
    end
  end

  def destroy
    @note = @user.notes.find(params[:id])
    if @note.destroy
      flash[:success] = 'Your note was successfully deleted.'
    else
      flash[:error] = 'Something went wrong. Your Note could not be deleted.'
    end
    redirect_to admin_profile_path
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
