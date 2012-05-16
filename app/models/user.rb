class User < ActiveRecord::Base
  has_inboxes
  acts_as_voter
  has_karma(:posts, :as => :user, :weight => 1)
  has_many :community_users, :dependent => :destroy
  has_many :communities, :through => :community_users
  
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # Include default devise modules. Others available are: :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable
  
  scope :filtered_by, lambda { |community_ids| joins(:community_users).where("community_users.community_id IN (?)", community_ids).uniq.compact }  
  
  def sample_community(community_type)
    array = communities.filtered_by(community_type)
    array.sample.name if array.present? 
  end
  
  def communities_count(community_type)
    length = communities.filtered_by(community_type).length
    "+#{length - 1}" if length > 1
  end
  
  def subscribed?
    Subscription.find_by_user_id(id).present? || created_at.advance(months: 1) > DateTime.now
  end
  
  def unread_messages_count
    
  end
  
  %W[ gender standing degree city field school ethnicity orientation religion relationship post_type ].each do |name|
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
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      if user.image != access_token.info.image
        User.update(user.id, :image => access_token.info.image, :large_image => "http://graph.facebook.com/#{data.id}/picture?type=large")
      end
      user
    else # Create a user with a stub password. 
      User.create!(
        :email => data.email, 
        :password => Devise.friendly_token[0,20],
        :provider => access_token.provider,
        :uid => data.id,
        :token => access_token.credentials.token,
        :name => data.name,
        :first_name => data.first_name,
        :last_name => data.last_name,
        :image => access_token.info.image,
        :large_image => "http://graph.facebook.com/#{data.id}/picture?type=large",
        :profile_url => data.link,
        :community_ids => data.gender.capitalize == "Male" ? ["1"] : ["2"]
        )   
    end
  end
  
  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:uid => data.uid, :provider => 'twitter').first
      user
    else # Create a user with a stub password. 
      User.create!(
        :provider => access_token.provider,
        :uid => data.id,
        :token => access_token.credentials.token,
        :name => data.name,
        :first_name => data.name.split(" ").first,
        :last_name => data.name.split(" ").last,
        :image => access_token.info.image,
        :twitter_name => access_token.info.nickname,
        :profile_url => "http://twitter.com/#{access_token.info.nickname}"
        )   
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
end
