class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate_admin_user!
    current_user.email == "abreu.jamil@gmail.com"
  end
end
