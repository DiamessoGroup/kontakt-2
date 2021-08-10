# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  layout 'admin-layout'

  def index
    @contacts = @user.contacts
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
      flash[:error] = 'Something went wrong.'
      render 'new'
    end
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :address, :title, :company, :favorite,
                                    :user_id)
  end
end
