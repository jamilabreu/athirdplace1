class CommunityUser < ActiveRecord::Base
  belongs_to :community
  belongs_to :user
  validates :community_id, :presence => true 
  validates :user_id, :presence => true
end
