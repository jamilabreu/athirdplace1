module ApplicationHelper
  def home_page
    params[:controller] == "communities" && params[:action] == "index"
  end
  
  def users_page
    params[:controller] == "users" && params[:action] == "index"
  end
  
  def newsletter_page
    params[:controller] == "subscriptions" && params[:action] == "index"
  end
  
  def edit_page
    params[:controller] == "users" && params[:action] == "edit"
  end
  
  def selected?(community)
    params[:ids].present? && params[:ids].include?(community.id.to_s)
  end

end
