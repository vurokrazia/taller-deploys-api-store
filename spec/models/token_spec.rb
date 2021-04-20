require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'validacion del model token' do
    subject { build(:token) }
    it 'Validar si token esta presente' do
      should validate_presence_of(:token)
    end
    it 'Validar si el user_id esta presente' do
      should validate_presence_of(:user_id)
    end
    it 'Validar si el expires_at esta presente' do
      should validate_presence_of(:expires_at)
    end
    it 'Validar si existe relacion con user' do
      should belong_to(:user)
    end
  end
end
