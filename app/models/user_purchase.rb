class UserPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_line, :building, :phone_num

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "Select"}
    validates :phone_num, format: { with: /\A[0-9]+\z/ }
  end

  with_options presence: true do
    validates :city
    validates :address_line
    validates :building
  end

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line: address_line, building: building, phone_num: phone_num)
  end
end