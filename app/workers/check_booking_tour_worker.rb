class CheckBookingTourWorker
  include Sidekiq::Worker

  def perform
    booking_tours = BookingTour.book.unpaid.where("created_at < ?", Time.zone.now - 48.hours) 
    booking_tours.each{ |booking_tour| booking_tour.destroy }
  end
end

