class CreateTourWorker
  include Sidekiq::Worker

  def perform
    10.times do |i|
      Category.create name: "cate #{i + 1}"
    end
  end
end
