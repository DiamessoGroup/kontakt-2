# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin-layout'

  def profile; end

  def create_contact; end

  def contact_list

  end
end
