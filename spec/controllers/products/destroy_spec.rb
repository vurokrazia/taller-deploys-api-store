require 'rails_helper'
RSpec.describe V1::ProductsController, type: :controller do
    describe 'Eliminar un producto' do
        let(:user) { create(:owner) }
        let(:bearer) { create(:token, user: user) }
        let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
        let(:product) { create(:product, store: user.store) }
        
        context "Eliminar producto satisfactoriamente" do
            before do
                request.headers.merge! headers
                delete(:destroy, format: :json, params: { id: product.id })
            end
            context 'Respuesta con status ok' do
                subject { response }
                it { is_expected.to have_http_status(:ok) }
            end
        end

        context 'Eliminar producto sin token' do
            before do 
                delete(:destroy, format: :json, params: { id: product.id } )
            end
            context 'Respuesta con status unauthorized' do
                subject { response }
                it { is_expected.to have_http_status(:unauthorized) }
            end
        end

    end
end