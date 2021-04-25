require 'rails_helper'

RSpec.describe V1::StoresController, type: :controller do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user ) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:stores) { create_list(:store,5) }
    context 'Consultar tienda por id' do
        before do 
          request.headers.merge! headers  
          get(:show, format: :json, params: { id: user.store.id } )
        end
        context 'Status 200' do
            subject { response }
            it { is_expected.to have_http_status(:ok) }
        end
        context 'Estructura correcta de la store' do
            subject { payload_test }
            it { is_expected.to include(:id, :name) }
        end
    end
    context 'No se puede consultar la tienda de otro usuario' do
        before do
            request.headers.merge! headers
            get(:show, format: :json, params: { id: rand(2..stores.size) })
        end
        context 'Status de response No autorizado' do
            subject { response }
            it { is_expected.to have_http_status(:unauthorized) }
        end
    end
    context 'Consultar tienda sin token' do
        before do
            get(:show, format: :json, params: { id: user.store.id })
        end
        context 'Status de response no autorizado' do
            subject{ response }
            it { is_expected.to have_http_status(:unauthorized) }
        end
    end
end