class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :gender

  with_options presence: true, numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :gender_id
  end
end
