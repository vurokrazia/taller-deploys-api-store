require 'rails_helper'
describe 'Rutas de producto' do
    it 'Ruta POST de products' do
        expect(post: '/v1/products').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'create'
        )
    end
    it 'Ruta PUT para actualzar productos' do
        expect(put: '/v1/products/1').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'update',
            id: '1'
        )
    end
    it 'Ruta index products' do
        expect(get: '/v1/products').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'index'
        )
    end
    it 'Ruta delete products' do
        expect(delete: '/v1/products/1').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'destroy',
            id: '1'
        )
    end
    it 'Ruta restaurar producto' do
        expect(post: '/v1/products/1/restore').to route_to(
            format: 'json',
            controller: 'v1/products',
            action: 'restore',
            product_id: '1'
        )
    end
end