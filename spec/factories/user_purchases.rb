FactoryBot.define do
  factory :user_purchase do
    postal_code {'123-4567'}
    prefecture_id {3}
    city         {'渋谷'}
    address_line {'1-1'}
    building {'渋谷ビル'}
    phone_num {'09012345678'}
    token {"tok_abcdefghijk00000000000000000"}
    user_id {1}
    item_id {1}
  end
end
