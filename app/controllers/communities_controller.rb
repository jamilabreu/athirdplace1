class CommunitiesController < ApplicationController
  def index
    @communities = Community.where("id IN (?)", User.all.collect(&:community_ids).flatten.uniq.compact)
    @users = User.page(params[:page])
  end
end
