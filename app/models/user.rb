class User < ApplicationRecord
    has_secure_password
    has_many :senga_likes, dependent: :destroy
    has_many :paint_likes, dependent: :destroy
    has_many :senga_requests, dependent: :destroy
    mount_uploader :image, ImagesUploader
end
