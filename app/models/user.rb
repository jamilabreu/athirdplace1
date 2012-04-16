class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and , :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  
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
        :gender => data.gender.capitalize,
        :profile_url => data.link
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
