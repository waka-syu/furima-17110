class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :text
    validates :state_id
    validates :category_id
    validates :fee_id
    validates :prefecture_id
    validates :delivery_date_id
    validates :value
  end
  
end
