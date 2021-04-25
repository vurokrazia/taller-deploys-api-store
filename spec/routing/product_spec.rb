require 'rails_helper'
describe 'Rutas de producto' do
    it 'Ruta post de products' do
        expect(post: '/v1/products').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'create'
        )
    end
end