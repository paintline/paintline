class Senga < ApplicationRecord
  paginates_per 3
  belongs_to :user
  has_many :senga_likes
  has_many :senga_categories
  has_many :senga_requests
  #mount_uploader :image, ImagesUploader
  mount_uploader :image, ImagesUploader
end
