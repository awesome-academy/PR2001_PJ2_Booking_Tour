class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :area, presence: true
  has_many :tours, dependent: :destroy
  has_many :images, dependent: :destroy, as: :imageable

  enum area: {nothern: "N", southern: "S", central: "C"}
end
