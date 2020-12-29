class Profile < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :gender

  belongs_to :user

  with_options presence: true, numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :gender_id
  end
end
