class AppController < ApplicationController
  def home
  end

  def about
  end

  def admin
    render layout: "admin-layout"
  end
end
