class Post < ActiveRecord::Base
  #acts_as_voteable
  auto_html_for :body do
    html_escape
    #linked_image
    #youtube(:width => 128, :height => 72)
    link :target => "_blank", :rel => "nofollow"
    twitter
    simple_format
  end  
  
  belongs_to :user
  has_many :community_posts, :dependent => :destroy
  has_many :communities, :through => :community_posts

  scope :filtered_by, lambda { |community_ids| joins(:community_posts).where("community_posts.community_id IN (?)", community_ids) }
  
  has_reputation :votes,
    :source => :user,
    :aggregated_by => :sum,
    :scopes => Community.all.map(&:subdomain).map(&:to_sym)

  %W[ post_type ].each do |name|
    define_method "#{name}" do
      self.communities.filtered_by("#{name}").map(&:name)
    end
    define_method "#{name}_ids" do
      self.communities.filtered_by("#{name}").map(&:id)
    end
    define_method "#{name}_ids=" do |val|
      self.community_ids += val.class == Array ? val : [val]
    end
  end
end
