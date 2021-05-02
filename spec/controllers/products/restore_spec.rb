require 'rails_helper'
RSpec.describe V1::ProductsController, type: :controller do
    describe 'Restaurar producto' do
        let(:user) { create(:owner) }
        let(:bearer) { create(:token, user: user) } 
        let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
        let(:product) { create(:product, store: user.store) }
        context 'Restaurar producto satisfactoriamente' do
            before do
                product.destroy
                request.headers.merge! headers
                post(:restore, format: :json, params: { product_id: product.id })
            end
            context 'Respuesta con estatus ok' do
                subject { response }
                it { is_expected.to have_http_status(:ok) }
            end
            context 'Estructura correcta del producto' do
                subject { payload_test }
                it { is_expected.to include(:id,:name, :price, :description, :store_id) }
            end
        end
        context 'Fallo restauracion del producto' do
            before do
                product.destroy
                post(:restore, format: :json, params: { product_id: product.id })
            end
            context 'Respuesta con status unauthorized' do
                subject { response }
                it { is_expected.to have_http_status(:unauthorized) }
            end
        end
    end
end