require 'rails_helper'

describe 'Rutas de store' do
    it 'Obtener una tienda en especifico por id' do
        expect(get: '/v1/stores/1').to route_to(
            format: 'json',
            controller: 'v1/stores',
            action: 'show',
            id: '1'
        )
    end
end