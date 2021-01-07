class UserPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address_line, :building, :phone_num, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフン(-)を含めてください"}
    validates :prefecture_id, numericality: { other_than: 1, message: "を選んでください"}
    validates :phone_num, format: { with: /\A\d{10,11}\z/ }
  end

  with_options presence: true do
    validates :city
    validates :address_line
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line: address_line, building: building, phone_num: phone_num, purchase_id: purchase.id)
  end
end