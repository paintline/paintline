class Category < ApplicationRecord
    has_many :senga_categories, dependent: :destroy
end
