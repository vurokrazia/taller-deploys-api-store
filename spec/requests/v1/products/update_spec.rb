require "swagger_helper"

RSpec.describe "v1/products", type: :request do
  path "/v1/products/{id}" do
    put("Actualizar producto") do
      tags :Products
      consumes "application/json"
      parameter(name: :payload, in: :body, description: "Atributos para actualizar el producto",
        schema: { "$ref" => "#/components/schemas/product" })
      parameter(name: :id, in: :path, description: "Id del producto",
        schema: { "#ref" => "#/components/schemas/product_id" })
      security [Bearer:[]]
      response(200, :successful) do
        let(:user) { create(:owner) }
        let(:user_token) { create(:token, user: user) }
        let(:product) { create(:product, store: user.store ) }
        let(:id) { product.id  }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          {
            product: {
              name: :update,
              description: "ejemplo de actualizacion de un producto",
              price: 100000
            }
          }
        }
        run_test!
      end
    end
  end
end
