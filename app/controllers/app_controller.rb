class AppController < ApplicationController
  before_action :authenticate_user!, only: :admin

  def home
  end

  def about
  end

  def admin
    render layout: "admin-layout"
  end
end
