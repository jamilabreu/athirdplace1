class CommunitiesController < ApplicationController
  def index
    @users = User.page(params[:page])
    @filters = {}
    
    categories = %w[ gender standing degree field ethnicity ]
    categories.each do |c|
     @filters[c] = Community.filtered_by(c)
    end

    respond_to do |format|   
      format.js { render 'users/index' }
      format.html
    end
  end
end
