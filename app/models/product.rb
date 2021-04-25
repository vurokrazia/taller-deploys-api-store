class Product < ApplicationRecord
  belongs_to :store
  validates :name, :description, :price, :store_id, presence: true
end
