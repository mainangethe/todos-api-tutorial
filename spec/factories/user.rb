FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.free_email("#{ name }") }
    password { Faker::Internet.password }
  end
end