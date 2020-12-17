FactoryBot.define do
  factory :item do
    name             {Faker::Name.name}
    text             {Faker::Lorem.sentence}
    state_id         {"2"}
    category_id      {"2"}
    fee_id           {"2"}
    prefecture_id    {"2"}
    delivery_date_id {"2"}
    value            {"15000"}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
