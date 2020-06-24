FactoryBot.define do
  factory :password_reset do
    email { "MyString" }
    token { "MyString" }
    token_expiration { "2020-06-24 13:34:48" }
    is_used { false }
  end
end
