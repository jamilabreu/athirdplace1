class CommunityPost < ActiveRecord::Base
  belongs_to :community
  belongs_to :post
  validates :community_id, :presence => true 
  validates :post_id, :presence => true
end
