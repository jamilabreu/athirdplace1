AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

# 1 - 2
genders = %W[ Male Female ]
genders.each do |gender|
  Community.create(name: gender, subdomain: gender.parameterize.delete("-"), community_type: "Gender")
end

# 3 - 5
standing = %W[ Undergrad #{'Grad Student'} Alumni ]
standing.each do |standing|
  Community.create(name: standing, subdomain: standing.parameterize.delete("-"), community_type: "Standing")
end

# 6 - 13
degree = %W[ #{"Persuing Bachelor's"} Bachelor's #{"Persuing Master's"} Master's #{"Pursuing Doctoral"} Doctoral Associate's #{"Pursuing Associate's"} ]
degree.each do |degree|
  Community.create(name: degree, subdomain: degree.parameterize.delete("-"), community_type: "Degree")
end

# 14 - 56
field = %W[ Agriculture Anthropology Architecture #{'Area Studies'} Archaeology Astronomy Biology Business Chemistry #{'Cognative Science'}
  #{'Computer Science'} #{'Ethnic Studies'} Divinity Economics Education Engineering Entertainment Environment Finance #{'Gender/Sexuality'} 
  Geography History Journalism Law Linguistics Literature Mathematics Medicine Military #{'Performing Arts'} Philosophy Physics Politics 
  #{'Public Health'} Psychology Religion #{'Social Work'} Sociology Sports Technology Transportation #{'Visual Arts'} Writing ]
field.each do |field|
  Community.create(name: field, subdomain: field.parameterize.delete("-"), community_type: "Field")
end

# 57 - 68
school = %W[ Yale Harvard Princeton Cornell Columbia Brown Dartmouth Stanford NYU Rutgers #{'The College of New Jersey'} ]
school.each do |school|
  Community.create(name: school, subdomain: school.parameterize.delete("-"), community_type: "School")
end

# 69 - 77
city = %W[ #{'New York'} #{'Los Angeles'} #{'San Francisco'} Boston Miami Chicago Dallas #{'San Antonio'} #{'San Diego'}]
city.each do |city|
  Community.create(name: city, subdomain: city.parameterize.delete("-"), community_type: "City")
end

# 78 - 79
relationship = %W[ Single #{'In a Relationship'} ]
relationship.each do |relationship|
  Community.create(name: relationship, subdomain: relationship.parameterize.delete("-"), community_type: "Relationship")
end

# 80 - 81
orientation = %W[ Heterosexual LGBTQ ]
orientation.each do |orientation|
  Community.create(name: orientation, subdomain: orientation.parameterize.delete("-"), community_type: "Orientation")
end

# 82 - 88
ethnicity = {"African" => ["African-American"], "Latino" => 
  %W[ Dominican #{'Puerto Rican'} Mexican Cuban Columbian Brazilian Bolivian Argentinian Chilean #{'Costa Rican'} ], "Asian" => []}
ethnicity.each do |key, value|
  c = Community.create(name: key, subdomain: key.parameterize, community_type: "Ethnicity")
  value.each { |v| c.children.create(name: v, subdomain: v.parameterize.delete("-"), community_type: "Ethnicity") }
end

# 89 - 103
religion = %W[ Christian Muslim Hindu Buddhist Athiest Sikh Jewish Rasta Wicca Taoist Confucianist Shintoist Jain Bahai ]
religion.each do |religion|
  Community.create(name: religion, subdomain: religion.parameterize.delete("-"), community_type: "Religion")
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
    community_ids: [Random.new.rand(1..2).to_s, Random.new.rand(3..5).to_s, Random.new.rand(6..13).to_s, Random.new.rand(14..56).to_s, 
                    Random.new.rand(57..68).to_s, Random.new.rand(69..77).to_s, Random.new.rand(78..79).to_s, Random.new.rand(80..81).to_s,
                    Random.new.rand(82..88).to_s, Random.new.rand(89..101).to_s]
  ) 
end