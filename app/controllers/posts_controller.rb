class PostsController < ApplicationController
  def index
    # Moderators
    @moderators = User.find_with_reputation(:votes, @community.subdomain.to_sym, :all, {:conditions => ["votes >= ?", 0], :order => "votes DESC, users.last_name"}).keep_if { |user| user.rank_for(:votes, @community.subdomain.to_sym) <= (User.filtered_by(@community_ids).length * 0.01).ceil }
    
    # Posts
    community_posts = Post.filtered_by(@community_ids)
    @posts = community_posts.find_with_reputation(:votes, @community.subdomain.to_sym, :all, {:conditions => ["votes >= ?", 4], :order => "votes DESC"})
    @recent_posts =  community_posts.find_with_reputation(:votes, @community.subdomain.to_sym, :all, {:conditions => ["votes < ? AND votes > ?", 4, -2], :order => "posts.created_at DESC"})

    #if params[:ids].present?
    #  filtered_posts = community_posts.delete_if { |post| (post.community_ids & params[:ids].map(&:to_i)).blank? || (post.community_ids & params[:ids].map(&:to_i)).length != params[:ids].length }
    #else
    #  filtered_posts = community_posts
    #end
    #@posts = Kaminari.paginate_array(filtered_posts.uniq.compact).page(params[:page]).per(30)
    # Filters
    #posts_community_ids = filtered_posts.map(&:community_ids).flatten.uniq.compact.delete_if { |id| id == @community.id || id == @community.parent_id }
    #@filters = {}
    #categories = current_user && current_user.subscribed? ? %w[ post_type ] : %w[ standing field ]
    #categories.each do |c|
    # @filters[c] = Community.where("communities.id IN (?)", posts_community_ids & Community.filtered_by(c).map(&:id))#.sort_by{|c| c.name}
    #end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.community_ids = [@community.id.to_s] #params[:post][:community_ids].compact.reject(&:blank?) + [params[:post][:post_type_ids]]
    
    if @post.save
      @post.add_evaluation(:votes, 1, current_user, @community.subdomain.to_sym)
      #redirect_to newsletter_path
      respond_to do |format|
        format.js
      end
    end
  end
  
  def vote_on
    @post = Post.find(params[:id])
    @user = @post.user
    community = @community.subdomain.to_sym
    @post.delete_evaluation(:votes, current_user, community) if @post.has_evaluation?(:votes, current_user, community)
    @post.add_evaluation(:votes, params[:up] == "true" ? 1 : -1, current_user, community)
    if params[:up] == "true"
      @user.increase_evaluation(:votes, 0.5, current_user, community)
    else
      @user.decrease_evaluation(:votes, 0.5, current_user, community)
    end
    respond_to do |format|
      format.js
    end
  end
  
  def cancel_post
    respond_to do |format|
      format.js
    end    
  end
end