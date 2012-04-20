AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')


genders = %W[ Male Female ]
genders.each do |gender|
  Community.create(name: gender, subdomain: gender.parameterize.delete("-"), community_type: "Gender")
end

standing = %W[ Undergrad #{'Grad Student'} Alumni ]
standing.each do |standing|
  Community.create(name: standing, subdomain: standing.parameterize.delete("-"), community_type: "Standing")
end

degree = %W[ #{"Persuing Bachelor's"} Bachelor's #{"Persuing Master's"} Master's #{"Persuing Doctoral"} Doctoral ]
degree.each do |degree|
  Community.create(name: degree, subdomain: degree.parameterize.delete("-"), community_type: "Degree")
end

field = %W[ Agriculture Anthropology Architecture #{'Area Studies'} Archaeology Astronomy Biology Business Chemistry #{'Cognative Science'}
  #{'Computer Science'} #{'Ethnic Studies'} Divinity Economics Education Engineering Entertainment Environment Finance #{'Gender/Sexuality'} 
  Geography History Journalism Law Linguistics Literature Mathematics Medicine Military #{'Performing Arts'} Philosophy Physics Politics 
  #{'Public Health'} Psychology Religion #{'Social Work'} Sociology Sports Technology Transportation #{'Visual Arts'} Writing ]
field.each do |field|
  Community.create(name: field, subdomain: field.parameterize.delete("-"), community_type: "Field")
end

school = %W[ Yale Harvard Princeton Cornell Columbia Brown Dartmouth Stanford NYU Rutgers #{'The College of New Jersey'} ]
school.each do |school|
  Community.create(name: school, subdomain: school.parameterize.delete("-"), community_type: "School")
end

ethnicity = {"Black" => [], "Latino" => ["Dominican", "Puerto Rican", "Mexican", "Cuban"], "Asian" => []}
ethnicity.each do |key, value|
  c = Community.create(name: key, subdomain: key.parameterize, community_type: "Ethnicity")
  value.each { |v| c.children.create(name: v, subdomain: v.parameterize.delete("-"), community_type: "Ethnicity") }
end



#Users
100.times do 
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
    about: Faker::Lorem.paragraph,
    community_ids: [Random.new.rand(1..2).to_s, Random.new.rand(3..5).to_s, Random.new.rand(6...11).to_s, Random.new.rand(12...54).to_s, 
                    Random.new.rand(55...66).to_s, Random.new.rand(66...72).to_s]
  ) 
end