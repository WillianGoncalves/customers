Fabricator(:user) do
  first_name 'foo'
  last_name 'bar'
  email 'foo@example.com'
  password '123456'
  password_confirmation '123456'
end
