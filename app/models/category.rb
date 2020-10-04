class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :area, :overview, presence: true

  has_rich_text :overview
  has_many :tours, dependent: :destroy
  has_many :images, dependent: :destroy, as: :imageable

  accepts_nested_attributes_for :images

  enum area: {nothern: "N", southern: "S", central: "C"}
end
