require 'rails_helper'
RSpec.describe V1::ProductsController, type: :controller do
    describe 'Listado de products' do
        let(:user) { create(:owner) }
        let(:bearer) { create(:token, user: user) }
        let(:headers) { { Authorization: "Bearer #{bearer.token}" } }

        context 'Se obtiene el listo de productos correctamente' do
            before do
                request.headers.merge! headers
                get(:index, format: :json)
            end
            context 'Respuesta con estatus ok' do
                subject{ response }
                it { is_expected.to have_http_status(:ok) }
            end
            context 'Estructura del listado correcta' do
                subject { payload_test }
                it { is_expected.to include(:products) }
            end
        end

        context 'Listado de productos sin tokens' do 
            before do
                get(:index, format: :json) 
            end
            context 'Respuesta con status unauthorized' do 
                subject { response }
                it { is_expected.to have_http_status(:unauthorized) }
            end
        end

    end
end