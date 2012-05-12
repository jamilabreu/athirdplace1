class PostsController < ApplicationController
  def index
    # Users
    community_posts = Post.filtered_by(@community_ids)
    if params[:ids].present?
      filtered_posts = community_posts.delete_if { |post| (post.community_ids & params[:ids].map(&:to_i)).blank? || (post.community_ids & params[:ids].map(&:to_i)).length != params[:ids].length }
    else
      filtered_posts = community_posts
    end
    @posts = Kaminari.paginate_array(filtered_posts).page(params[:page]).per(15)
    
    # Filters
    posts_community_ids = filtered_posts.map(&:community_ids).flatten.uniq.compact.delete_if { |id| id == @community.id || id == @community.parent_id }
    @filters = {}
    categories = current_user && current_user.subscribed? ? %w[ post_type field ] : %w[ standing field ]
    categories.each do |c|
     @filters[c] = Community.where("communities.id IN (?)", posts_community_ids & Community.filtered_by(c).map(&:id))#.sort_by{|c| c.name}
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
