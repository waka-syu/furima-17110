class UserPurchase
  include ActiveModel::Model
  attr_assessor :postal_code, :prefecture_id, :city, :address_line, :building, :phone_num

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank"}
  end

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line: address_line, building: building, phone_num: phone_num)
  end
end