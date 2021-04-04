FactoryBot.define do
  factory :user do
    email { "jesus@MyString.com" }
    age { 18 }
    password_digest { "MyString" }
    type { "test" }
  end
end
