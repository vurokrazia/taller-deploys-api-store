require 'rails_helper'
RSpec.describe V1::ProductsController, type: :controller do
    describe 'Registro de productos' do
        let(:user) { create(:owner) }
        let(:bearer) { create(:token, user: user) }
        let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
        let(:product) {
            {
                name: Faker::Book.title,
                description: Faker::Lorem.sentence(word_count: 50),
                price: rand(1..100)
            }
        }
        context 'Registro del producto correctamente' do
            before do 
                request.headers.merge! headers
                post(:create, format: :json, params: { product: product  })
            end
            context 'Respuesta con status de created' do
                subject { response }
                it { is_expected.to have_http_status(:created) }
            end
            context 'Estructura correcta del producto' do
                subject { payload_test }
                it { is_expected.to include(:id, :name, :price, :description, :created_at, :updated_at, :store_id) }
            end
        end
        context 'Fallo registro del producto' do
            before do
                product[:name] = ""
                request.headers.merge! headers
                post(:create, format: :json, params: {product: product})
            end
            context 'Respuesta con status de bad request' do
                subject {response}
                it { is_expected.to have_http_status(:bad_request) }
            end
            context 'Estructura del lista de errores correcto' do
                subject { payload_test }
                it { is_expected.to include(:errors) }
            end
        end
        context 'Registro de producto sin token' do
            before do
                post(:create, format: :json, params: { product: :product })
            end
            context 'Respuesta con status (unauthorized)' do
                subject { response }
                it { is_expected.to have_http_status(:unauthorized) }
            end
        end
    end
end