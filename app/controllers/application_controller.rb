class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  
  def authenticate_admin_user!
    current_user.email == "abreu.jamil@gmail.com"
  end
  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

private
  def load_community
    @community = Community.find_by_subdomain!(request.subdomain) if request.subdomain.present?
  end
end
