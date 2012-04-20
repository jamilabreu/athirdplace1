class Community < ActiveRecord::Base
  has_ancestry
  has_many :community_users
  has_many :users, :through => :community_users
  
  validates :name, :presence => true, :uniqueness => true
  
  scope :filtered_by, lambda { |community_type| where( :community_type => community_type.titleize ) } 
end
