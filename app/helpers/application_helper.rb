module ApplicationHelper
  def community_name
    @community ? "#{@community.name} Student + Alumni Network" : "thirdplace"
  end
  
  def voted_on?(object)
    object.has_evaluation?(:votes, current_user, @community.subdomain.to_sym)
  end
  
  def voted_for?(object)
    object.evaluation_value(:votes, current_user, @community.subdomain.to_sym) > 0
  end

  def voted_against?(object)
    object.evaluation_value(:votes, current_user, @community.subdomain.to_sym) < 0
  end
  
  def vote_count(object)
    object.reputation_value_for(:votes, @community.subdomain.to_sym).round
  end
    
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
