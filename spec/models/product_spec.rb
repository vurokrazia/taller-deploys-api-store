require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validaciones del producto ' do
    subject{ build(:product) }

    it 'Validar si store id esta presente' do
      should validate_presence_of(:store_id)
    end

    it 'Validar si name esta presente' do
      should validate_presence_of(:name)
    end

    it 'Validar si description esta presente' do
      should validate_presence_of(:description)
    end

    it 'Validar si price esta presente' do
      should validate_presence_of(:price)
    end

    it 'Validar belongs store' do
      should belong_to(:store)
    end

  end
end
