FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password {Faker::Name.name}
  end
end
