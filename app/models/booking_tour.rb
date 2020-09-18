class BookingTour < ApplicationRecord
  belongs_to :tour_detail
  belongs_to :user

  validates :quantity, presence: true, numericality: true

  enum booking_status: %i[cancel book]
  enum payment_status: %i[unpaid paid]
end