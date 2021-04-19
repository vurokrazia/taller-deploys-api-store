require 'rails_helper'
RSpec.describe V1::UsersController, type: :controller do
    describe 'Inicio de sesion del usuario' do
        let(:user) { create(:owner, password:'123456') }
        context 'Inicio de sesión correcto' do
            before do 
                post(:login,format: :json, params: { 
                    user: {
                        email: user.email,
                        password: 123456   
                    }
                })
            end
            context 'Estatus correcto (OK)' do
                subject { response }
                it { is_expected.to have_http_status(:ok) }
            end
            context 'Estructura de respuesta login correcta' do
                subject { payload_test }
                it { is_expected.to include(:id, :email, :age, :store) }
            end
        end
        context 'Inicio de sesión fallido' do
            before do 
                post(:login, format: :json, params: {
                    user: {
                        email: user.email,
                        password: ''
                    }
                })
            end
            context 'Estatus de correcto (bad_request)' do
                subject {response}
                it { is_expected.to have_http_status(:bad_request) }
            end
            context 'Estructura de login correcta' do
                subject { payload_test }
                it { is_expected.to include(:errors) }
            end
        end
    end
end