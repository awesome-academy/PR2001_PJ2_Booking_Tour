class Tour < ApplicationRecord
  belongs_to :category

  has_many :tour_details, dependent: :destroy
  has_many :hotel_tours
  has_many :hotels, through: :hotel_tours
  has_rich_text :itinerary
  has_rich_text :price_info

  validates :name, presence: true, length: { maximum: 100 }
  validates :itinerary,:price_info, :transport, presence: true
  validates :price, :coupon, :seats, presence: true, numericality: true

  ransack_alias :tour_details, :tour_details_departure_time
end
