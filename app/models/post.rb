class Post < ActiveRecord::Base
  has_many :community_posts, :dependent => :destroy
  has_many :communities, :through => :community_posts
  belongs_to :user
  
  scope :filtered_by, lambda { |community_ids| joins(:community_posts).where("community_posts.community_id IN (?)", community_ids).uniq.compact }
  
  %W[ post_type ].each do |name|
    define_method "#{name}" do
      self.communities.filtered_by("#{name}").map(&:name)
    end
    define_method "#{name}_ids" do
      self.communities.filtered_by("#{name}").map(&:id)
    end
    define_method "#{name}_ids=" do |val|
      self.communities.delete_all if name == "gender"
      self.community_ids += val.class == Array ? val : [val]
    end
  end
end
