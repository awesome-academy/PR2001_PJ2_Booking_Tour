class Campaign < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }

  enum sale_type: [:percent, :number]
end
