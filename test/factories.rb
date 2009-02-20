require 'factory_girl'


# sequences

Factory.sequence :email do |n|
  "#{random_string}#{n}@example.com" 
end


# factories

Factory.define :user do |u|
  u.email                 { Factory.next(:email) }
  u.name                  "Name Last"
  u.password              "password"
  u.password_confirmation "password"
end