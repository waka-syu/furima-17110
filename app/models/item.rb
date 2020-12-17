class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :fee
  belongs_to :delivery_date
  belongs_to :prefecture

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :text
    validates :image
  end

  validates :value, presence: true,  numericality: { greater_then_or_equal_to: 300, less_then_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }

  with_options presence: true, numericality: { other_then: 1 } do
    validates :state_id
    validates :category_id
    validates :fee_id
    validates :prefecture_id
    validates :delivery_date_id
  end
end
