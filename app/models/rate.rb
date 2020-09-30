class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :value, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 10}

end