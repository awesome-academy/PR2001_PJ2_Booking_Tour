class TourDetail < ApplicationRecord
  belongs_to :tour

  has_many :booking_tours, dependent: :destroy
  
  validates :departure_time, :return_time, presence: true
  validate :check_time, if: -> { departure_time.present? && return_time.present? }

  private

  def check_time
    errors.add(:return_time, 'must not less than Departure time') if return_time < departure_time
  end
end