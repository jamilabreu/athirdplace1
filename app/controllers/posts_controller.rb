class PostsController < ApplicationController
  def index
    # Posts
    community_posts = Post.filtered_by(@community_ids)
    
    if params[:ids].present?
      filtered_posts = community_posts.delete_if { |post| (post.community_ids & params[:ids].map(&:to_i)).blank? || (post.community_ids & params[:ids].map(&:to_i)).length != params[:ids].length }
    else
      filtered_posts = community_posts
    end
    if params[:newest]
      filtered_posts = filtered_posts.sort! { |a,b| b.created_at <=> a.created_at }
    else
      filtered_posts = filtered_posts.sort! { |a,b| b.plusminus <=> a.plusminus }
    end
    @posts = Kaminari.paginate_array(filtered_posts).page(params[:page]).per(30)
    
    # Filters
    posts_community_ids = filtered_posts.map(&:community_ids).flatten.uniq.compact.delete_if { |id| id == @community.id || id == @community.parent_id }
    @filters = {}
    categories = current_user && current_user.subscribed? ? %w[ post_type ] : %w[ standing field ]
    categories.each do |c|
     @filters[c] = Community.where("communities.id IN (?)", posts_community_ids & Community.filtered_by(c).map(&:id))#.sort_by{|c| c.name}
    end
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
    @post.community_ids = params[:post][:community_ids].compact.reject(&:blank?) + [params[:post][:post_type_ids]]
    
    if @post.save
      current_user.vote_exclusively_for(@post)
      redirect_to posts_path(:newest => true)
    else
      redirect_to posts_path
    end
  end
  
  def vote_on
    @post = Post.find(params[:id])
    params[:up].present? ? current_user.vote_exclusively_for(@post) : current_user.vote_exclusively_against(@post)
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