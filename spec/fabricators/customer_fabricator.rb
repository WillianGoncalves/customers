Fabricator(:customer) do
  first_name Faker::Name.first_name
  last_name  Faker::Name.last_name
  gender     1
  avatar     Faker::Avatar.image
end
