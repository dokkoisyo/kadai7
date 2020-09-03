class Picture < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 60000 }
  mount_uploader :image, ImageUploader
end
