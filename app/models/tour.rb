class Tour < ApplicationRecord
  belongs_to :category

  has_many :images, dependent: :destroy
  has_many :tour_details, dependent: :destroy
  has_many :rates, dependent: :destroy

  accepts_nested_attributes_for :images

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :price, :coupon, :seats, presence: true, numericality: true

  ransack_alias :tour_details, :tour_details_departure_time
end