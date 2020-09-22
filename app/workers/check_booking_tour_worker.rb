class CheckBookingTourWorker
  include Sidekiq::Worker

  def perform 
    BookingTour.book.unpaid.each{ |booking_tour| booking_tour.destroy }
  end
end

