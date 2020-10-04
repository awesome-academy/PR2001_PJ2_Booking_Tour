class CreateHotelTour
  attr_reader :hotel_params, :tour

  def initialize(hotel_params, tour)
    @hotel_params = hotel_params
    @tour = tour
  end

  def perform
    hotel_params.each do |hotel|
      if (hotel[:extra_fee] == 0) || (hotel[:id].present? && hotel[:extra_fee].present?) 
        HotelTour.create!(tour_id: tour.id, hotel_id: hotel[:id].to_i, extra_fee: hotel[:extra_fee].to_i)
      elsif hotel[:id].blank? && hotel[:extra_fee].blank?
        next
      else
        raise StandardError
      end
    end
  end
end