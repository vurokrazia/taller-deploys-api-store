require "swagger_helper"

RSpec.describe "v1/products", type: :request do
  path "/v1/products/" do
    post("Registro de products") do
      tags :Products
      consumes "application/json"
      parameter(name: :payload, in: :body, description: "Attributos para crear el producto",
                schema: { "$ref" => "#/components/schemas/product" })
      security [Bearer: []]
      response(201, :successful) do
        let(:user) { create :owner }
        let(:user_token) { create :token, user: user }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          {
            product: {
              name: :test,
              description: :example,
              price: 50,
            },
          }
        }
        run_test!
      end
    end
  end
end
