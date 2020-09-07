class Image < ApplicationRecord
  belongs_to :tour
  mount_uploader :link, PictureUploader
  validates :link, presence: true
end