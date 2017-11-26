100.times do |n|
  email = Faker::Internet.email
  name = Faker::Name.name
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password
            )
end
