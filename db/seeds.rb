AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

#Users
40.times do 
  random_uid = Random.new.rand(300000..302715)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  
  User.create!(
    email: Faker::Internet.email,
    password: Devise.friendly_token[0,20],
    provider: "Facebook",
    uid: random_uid,
    name: "#{first_name} #{last_name}",
    first_name: first_name, 
    last_name: last_name,
    image: "http://graph.facebook.com/#{random_uid}/picture?type=square",
    large_image: "http://graph.facebook.com/#{random_uid}/picture?type=large",
    gender: random_uid%2 == 0 ? "Male" : "Female"
  ) 
end