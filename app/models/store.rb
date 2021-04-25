class Store < ApplicationRecord
    has_one :owner
    has_many :employees
    has_many :products
    validates :name, presence: true
end
