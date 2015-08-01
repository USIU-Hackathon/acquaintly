class HomeController < ApplicationController
  layout 'home'
  def index
    redirect_to current_user if user_signed_in?
  end
end
