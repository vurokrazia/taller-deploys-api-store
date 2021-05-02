require 'rails_helper'
RSpec.describe V1::ProductsController, type: :controller do
    describe 'Actualizar productos' do
        let(:user) { create(:owner) }
        let(:bearer) { create(:token, user: user) }
        let(:headers) { { Authorization: "Bearer #{bearer.token}" } } 
        let(:product) { create(:product, store: user.store) }

        context 'Producto actualizado correctamente' do
            before do
                request.headers.merge! headers
                put(:update, format: :json, params: { id: product.id, product: { name: "Test" } })
            end
            context 'Respuesta con estatus ok' do
                subject{ response }
                it { is_expected.to have_http_status(:ok) }
            end
            context 'Estructura del producto correcta' do
                subject { payload_test }
                it { is_expected.to include(:id, :price, :description, :name, :store_id) }
            end
        end

        context 'El producto no se puede actualizar' do
            before do
                request.headers.merge! headers
                put(:update, format: :json, params: { id: product.id, product: { name: "" } })
            end
            context 'Respuesta con status bad request' do
                subject { response }
                it { is_expected.to have_http_status(:bad_request) }
            end
            context 'Estructura de listado de errores correcta' do
                subject { payload_test }
                it { is_expected.to include(:errors) }
            end
        end

        context 'Actualizar producto sin token' do
            before do
                put(:update, format: :json, params: { id: product.id, product: { name: "test 2" }  })
            end
            context 'Respuesta con status unauthorized' do
                subject { response }
                it { is_expected.to have_http_status(:unauthorized) }
            end
        end

    end
end