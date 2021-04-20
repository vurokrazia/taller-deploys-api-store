FactoryBot.define do
  factory :token do
    token { SecureRandom.hex }
    expires_at { Faker::Date.in_date_period }
  end
end
