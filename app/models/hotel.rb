class Hotel < ApplicationRecord
  has_and_belongs_to_many :tours
  has_many :images, dependent: :destroy, as: :imageable

  validates :name, presence: true, length: { maximum: 100 }

  accepts_nested_attributes_for :images
end