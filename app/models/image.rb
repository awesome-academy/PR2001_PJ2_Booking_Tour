class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  mount_uploader :link, PictureUploader
  validates :link, presence: true
end