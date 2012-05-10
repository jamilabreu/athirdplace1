class UsersController < ApplicationController
  skip_before_filter :check_user!, :only => [:edit, :update]
  def index
    # Pagination
    params[:seed] ||= Random.new_seed
    srand params[:seed].to_i
    
    # Users
    community_users = User.filtered_by(@community_ids)
    if params[:ids].present?
      filtered_users = community_users.delete_if { |user| (user.community_ids & params[:ids].map(&:to_i)).blank? || (user.community_ids & params[:ids].map(&:to_i)).length != params[:ids].length }
    else
      filtered_users = community_users
    end
    @users = Kaminari.paginate_array(filtered_users.shuffle).page(params[:page]).per(15)
    
    # Filters
    users_community_ids = filtered_users.map(&:community_ids).flatten.uniq.compact.delete_if { |id| id == @community.id || id == @community.parent_id }
    @filters = {}
    categories = current_user && current_user.subscribed? ? %w[ gender standing degree field relationship orientation religion ethnicity school ] : %w[ standing field ]
    categories.each do |c|
     @filters[c] = Community.where("communities.id IN (?)", users_community_ids & Community.filtered_by(c).map(&:id))#.sort_by{|c| c.name}
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
    
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "edit"
    end
  end
  
  #def vote_up
  #  @user = User.find(params[:id])
  #  if current_user.subscribed?
  #    current_user.vote_for(@user)
      #Pusher["presence-user-channel-#{@user.id}"].trigger('introduction-notice', {:first_name => @user.first_name, :genderize => genderself(@user)})
      #UserMailer.delay.send_introduction(@user, current_user) unless @user == current_user
  #    respond_to do |format|
  #      #flash.now[:notice] = "You just introduced yourself to #{@user.first_name}."
  #      format.js
  #    end
  #  else
  #    redirect_to new_subscription_path(:referral => @user.id)
  #  end
  #end
end
