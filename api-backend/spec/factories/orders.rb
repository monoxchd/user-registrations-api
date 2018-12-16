FactoryBot.define do
    factory :order do
        device { Faker::Lorem.sentence  }
        imei { Faker::IDNumber.valid }
        yearly_price { Faker::Number.decimal(2) }
        installments { Faker::Number.between(1, 12) }
        user_id nil
    end
end