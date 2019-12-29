class Paint < ApplicationRecord
  belongs_to :user
  belongs_to :senga
  mount_uploader :image, ImagesUploader
end
