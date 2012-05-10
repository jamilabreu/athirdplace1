class CommunitiesController < ApplicationController
  def index
    @communities = Community.all
    @users = User.page(params[:page])
  end
end
