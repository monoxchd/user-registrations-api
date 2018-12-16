FactoryBot.define do
    factory :user do
        name { Faker::Name.name }
        cpf { Faker::IDNumber.valid }
        email { Faker::Internet.free_email }
    end
end