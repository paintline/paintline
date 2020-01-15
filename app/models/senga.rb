class Senga < ApplicationRecord
  paginates_per 3
  belongs_to :user
  has_many :senga_likes, dependent: :destroy
  has_many :senga_categories, dependent: :destroy
  has_many :senga_requests, dependent: :destroy
  #mount_uploader :image, ImagesUploader
  mount_uploader :image, ImagesUploader
  
  validates :tittle, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 100 }
end
