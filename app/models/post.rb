class Post < ActiveRecord::Base
  has_many :community_posts, :dependent => :destroy
  has_many :communities, :through => :community_posts
  
  scope :filtered_by, lambda { |community_ids| joins(:community_posts).where("community_posts.community_id IN (?)", community_ids).uniq.compact }  
  
end
