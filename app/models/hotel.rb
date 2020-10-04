class Hotel < ApplicationRecord
  has_many :hotel_tours
  has_many :tours, through: :hotel_tours
  has_many :images, dependent: :destroy, as: :imageable
  has_rich_text :overview

  validates :name, presence: true, length: { maximum: 100 }

  accepts_nested_attributes_for :images
end