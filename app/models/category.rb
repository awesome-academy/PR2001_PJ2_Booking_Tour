class Category < ApplicationRecord
  has_many :tours
  validates :category_name, presence: true, length: {maximum: 100}
end

