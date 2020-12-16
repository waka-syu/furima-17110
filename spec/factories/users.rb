FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password             {"test12"}
    password_confirmation {"test12"}
    last_name            {"山田"}
    first_name           {"太郎"}
    last_kana            {"ヤマダ"}
    first_kana           {"タロウ"}
    birth_date {Faker::Date.birthday}
  end
end