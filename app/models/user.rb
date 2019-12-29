class User < ApplicationRecord
    has_secure_password
    has_many :user_likes
    has_many :senga_requests
    mount_uploader :image, ImagesUploader
end
