FactoryBot.define do
  factory :profile do
    status_message   {Faker::Lorem.sentence}
    prefecture_id    {2}
    gender_id        {3}
    association :user
  end
end
