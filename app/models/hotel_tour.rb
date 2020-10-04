class HotelTour < ApplicationRecord
  belongs_to :tour
  belongs_to :hotel

  scope :get_by_hotel_id, -> (hotel_id){ where hotel_id: hotel_id }
  scope :get_by_tour_id, -> (tour_id){ where tour_id: tour_id }
end