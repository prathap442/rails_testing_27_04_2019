#Factory bot is a fixture replacement, 
#which allows you to populate sample data while testing application. Here’s how to use it:
#Create a factory file for specific entity that is used in our application, 
#considering our example, I am creating spec/factories/user_factory.rb file and it looks like:
require 'faker'
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end

  factory :users do 
    User.all
  end
end
