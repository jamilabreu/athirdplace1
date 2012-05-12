AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

# 1 - 2
genders = %W[ Female Male ]
genders.each do |gender|
  Community.create(name: gender, subdomain: gender.parameterize.delete("-"), community_type: "Gender")
end

# 3 - 5
standing = %W[ Alumni #{'Grad Student'} Undergraduate ]
standing.each do |standing|
  Community.create(name: standing, subdomain: standing.parameterize.delete("-"), community_type: "Standing")
end

# 6 - 13
degree = %W[ Associate's Bachelor's Master's Doctoral #{"Pursuing Associate's"} #{"Persuing Bachelor's"} #{"Persuing Master's"} #{"Pursuing Doctoral"} ]
degree.each do |degree|
  Community.create(name: degree, subdomain: degree.parameterize.delete("-"), community_type: "Degree")
end

# 14 - 56
field = %W[ Agriculture Anthropology Architecture #{'Area Studies'} Archaeology Astronomy Biology Business Chemistry #{'Cognitive Science'} Communications
  #{'Computer Science'} #{'Ethnic Studies'} Divinity Economics Education Engineering Entertainment Environment Finance #{'Gender/Sexuality'} 
  Geography History Journalism Law Linguistics Literature Mathematics Medicine Military #{'Performing Arts'} Philosophy Physics Politics 
  #{'Public Health'} Psychology Religion #{'Social Work'} Sociology Sports Technology Transportation #{'Visual Arts'} Writing ]
field.each do |field|
  Community.create(name: field, subdomain: field.parameterize.delete("-"), community_type: "Field")
end

# 57 - 58
relationship = %W[ Single #{'In a Relationship'} Married ]
relationship.each do |relationship|
  Community.create(name: relationship, subdomain: relationship.parameterize.delete("-"), community_type: "Relationship")
end

# 68 - 69
orientation = %W[ Heterosexual LGBTQ ]
orientation.each do |orientation|
  Community.create(name: orientation, subdomain: orientation.parameterize.delete("-"), community_type: "Orientation")
end

# 70 - 84
religion = %W[ Athiest Bahai Buddhist Christian Confucianist Hindu Jain Jewish Muslim Rasta Shintoist Sikh Taoist Wicca ]
religion.each do |religion|
  Community.create(name: religion, subdomain: religion.parameterize.delete("-"), community_type: "Religion")
end

# 84 - 104
ethnicity = {
  "African" => %W[ African-American Guyanese Nigerian Ethiopian Eritrean #{'South African'} Egyptian Algerian #{'Cape Verdean'} ], 
  "Latino" => %W[ Dominican #{'Puerto Rican'} Mexican Cuban Columbian Brazilian Bolivian Argentinian Chilean #{'Costa Rican'} Ecuadorian Guyanese 
    Uruguayan Peruvian Paraguayan Portuguese Guatemalan Salvadorian Venezuelan Panamanian Honduran ], 
  "West Indian" => %W[ Jamaican Trinidadian Haitian ],
  "Middle Eastern" => %W[ Afghan Albanian Vietnamese Armenian Indonesian Israeli ],
  "Asian" => %W[ Chinese Indian Filipino Japanese Taiwanese Korean ],
  "European" => %W[ Italian Irish French German British Dutch Russian Spaniard Greek Scottish ],
  "Native American" => []}
ethnicity.each do |key, value|
  c = Community.create(name: key, subdomain: key.parameterize, community_type: "Ethnicity")
  value.each { |v| c.children.create(name: v, subdomain: v.parameterize.delete("-"), community_type: "Ethnicity") }
end

# 105 - 106
post_type = %W[ Announcement Event ]
post_type.each do |post_type|
  Community.create(name: post_type, subdomain: post_type.parameterize.delete("-"), community_type: "post_type")
end

#Schools
require 'csv'
CSV.foreach("db/data/schools.csv") do |row|
  Community.create(name: row[1], subdomain: row[1].parameterize.delete("-"), city: row[2], state: row[3], zip_code: row[4].to_i, community_type: "School") if Community.where(school_id: row[0]).blank?
end

#Cities
CSV.foreach("db/data/majorcities.csv") do |row|
  name = row[0]
  region_code = row[1].blank? ? nil : Carmen::state_code(row[1])
  #coordinates = Geocoder.coordinates("#{row[0]}, #{row[3]}")
  #latitude = coordinates.nil? ? nil : coordinates.first
  #longitude = coordinates.nil? ? nil : coordinates.last
  Community.create(name: name, subdomain: name.parameterize.delete("-"), community_type: "City", region: row[1], region_code: region_code, country: row[3], country_id: row[4]) unless name.blank? 
end


#Users
50.times do 
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
                    Random.new.rand(57..58).to_s, Random.new.rand(59..60).to_s, Random.new.rand(61..75).to_s, "88"]
  ) 
end

#Posts
50.times do
  random_uid = Random.new.rand(300000..302715)
  Post.create!(
    title: Faker::Lorem.paragraph,
    body: Faker::Lorem.paragraph,
    user_id: Random.new.rand(1..50),
    community_ids: [Random.new.rand(1..2).to_s, Random.new.rand(3..5).to_s, Random.new.rand(6..13).to_s, Random.new.rand(14..56).to_s, 
                    Random.new.rand(57..58).to_s, Random.new.rand(59..60).to_s, Random.new.rand(61..75).to_s, "88", Random.new.rand(138..139).to_s]
  )
end