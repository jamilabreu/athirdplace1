class UsersController < ApplicationController
  
  def index
    params[:seed] ||= Random.new_seed
    srand params[:seed].to_i
    
    subcommunities = @community.child_ids << @community.id
    all_users = User.joins(:community_users).where("community_users.community_id IN (?)", subcommunities).uniq.compact
    if params[:ids].present?
      users = all_users.delete_if { |user| (user.community_ids & params[:ids].map(&:to_i)).blank? || (user.community_ids & params[:ids].map(&:to_i)).length != params[:ids].length }
    else
      users = all_users
    end
    
    @users = Kaminari.paginate_array(users.shuffle).page(params[:page]).per(15)
    
    users_community_ids  = @users.map(&:community_ids).flatten.uniq.compact.delete_if { |id| id == @community.id || id == @community.parent_id }
    @filters = {}
    categories = current_user && current_user.subscribed? ? %w[ gender standing degree field school orientation religion ethnicity ] : %w[ gender standing field ]
    categories.each do |c|
     @filters[c] = Community.where("communities.id IN (?)", users_community_ids & Community.filtered_by(c).map(&:id))
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    #params[:user][:community_ids].concat(params[:user][:communities])
    #params[:user][:communities].each { |x| params[:user][:community_ids] << x  }
    #params[:user].delete :community_users_attributes
    
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "edit"
    end
  end
end
