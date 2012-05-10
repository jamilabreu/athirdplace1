class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_user!
  before_filter :load_community
  
  def authenticate_admin_user!
    current_user.email == "abreu.jamil@gmail.com"
  end
  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

private
  def check_user!
    if user_signed_in? 
      if current_user.standing.blank? || current_user.degree.blank? || current_user.school.blank? || current_user.field.blank?
        redirect_to edit_path, :alert => "Please select your standing, degree, school(s), and field(s) of interest."
      end
    end
  end
  def load_community
    if request.subdomain.present?
      @community = Community.find_by_subdomain!(request.subdomain)
      @community_ids = @community.subtree_ids
    end
  end
end
