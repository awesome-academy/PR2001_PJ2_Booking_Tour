class CreateTourWorker
  include Sidekiq::Worker

  def perform(tour_attributes)
    Tour.create(tour_attributes)
  end
end
