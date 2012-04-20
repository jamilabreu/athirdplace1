module ApplicationHelper
  def home_page
    params[:controller] == "communities" && params[:action] == "index"
  end
  
  def selected?(community)
    params[:ids].present? && params[:ids].include?(community.id.to_s)
  end
end
