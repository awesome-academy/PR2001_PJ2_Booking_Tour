class Tour < ApplicationRecord
  belongs_to :category

  has_many :images, dependent: :destroy, as: :imageable
  has_many :tour_details, dependent: :destroy
  has_and_belongs_to_many :hotels

  accepts_nested_attributes_for :images

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, :restaurant, :tourist_attraction, :transport, presence: true
  validates :price, :coupon, :seats, presence: true, numericality: true

  ransack_alias :tour_details, :tour_details_departure_time
end