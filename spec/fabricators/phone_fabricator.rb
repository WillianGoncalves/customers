Fabricator(:phone) do
  number { Faker::PhoneNumber.phone_number }
end
