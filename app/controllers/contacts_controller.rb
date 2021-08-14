# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  layout 'admin-layout'

  def index
    if params.key?(:favorite)
      case params[:favorite]
      when '1'
        @contacts = @user.contacts.where(favorite: true).paginate(page: params[:page])
      when '0'
        @contacts = @user.contacts.where(favorite: false).paginate(page: params[:page])
      end
    else
      @contacts = @user.contacts.paginate(page: params[:page])
    end
  end

  def new
    @contact = @user.contacts.build
  end

  def create
    @contact = @user.contacts.build(contact_params)
    if @contact.save
      flash[:success] = 'Your Contact was successfully created.'
      redirect_to user_contacts_path
    else
      flash.now[:error] = 'Something went wrong.'
      render :new
    end
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :address, :title, :company, :favorite,
                                    :user_id)
  end
end
