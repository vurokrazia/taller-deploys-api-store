require "swagger_helper"

RSpec.describe "v1/products", type: :request do
  path "/v1/products/" do
    post("Registro de products") do
      tags :Products
      consumes "application/json"
      parameter(name: :payload, in: :body, description: "Attributos para crear el producto",
                schema: { "$ref" => "#/components/schemas/product" })
      security [Bearer: []]
      let(:user) { create :owner }
      let(:user_token) { create :token, user: user }
      let(:Authorization) { "Bearer #{user_token.token}" }
      response(201, :Successful) do
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
      response(400, "Incorrect Params") do
        let(:payload) {
          {
            product: {
              name: "",
            },
          }
        }
        run_test!
      end
      response(401, "Bad Token") do
        let(:Authorization) { "Bearer" }
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
