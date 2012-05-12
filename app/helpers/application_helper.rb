module ApplicationHelper
  def home_page
    params[:controller] == "communities" && params[:action] == "index"
  end
  
  def users_page
    params[:controller] == "users" && params[:action] == "index"
  end
  
  def posts_page
    params[:controller] == "posts" && params[:action] == "index"
  end
  
  def edit_page
    params[:controller] == "users" && params[:action] == "edit"
  end
  
  def conversations_page
    params[:controller] == "inboxes/discussions" && params[:action] == "index"
  end
  
  def selected?(community)
    params[:ids].present? && params[:ids].include?(community.id.to_s)
  end
  
  def new_filter_ids(community)
    selected?(community) ? (params[:ids] - [community.id.to_s]) : (params[:ids].to_a | [community.id.to_s])
  end
end
