class Community < ActiveRecord::Base
  has_ancestry
  has_many :community_users
  has_many :users, :through => :community_users
  has_many :community_posts
  has_many :posts, :through => :community_posts

  validates :name, :presence => true, :uniqueness => true
  
  scope :filtered_by, lambda { |community_type| where( :community_type => community_type.titleize ) }
  
  def city_and_country
    "#{name}, #{country == 'United States' && region_code.present? ? region_code + ', USA' : country}"
  end
  
  def city_and_region
   region_code.present? ? "#{name}, #{region_code}" : city
  end
end
