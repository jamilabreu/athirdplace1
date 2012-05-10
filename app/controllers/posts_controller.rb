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
  end

  def show
    @post = Post.find(params[:id])
  end
end
