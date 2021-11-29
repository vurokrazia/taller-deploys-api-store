require "swagger_helper"

RSpec.describe "v1/products", type: :request do
  path "/v1/products/{product_id}/restore" do
    post("Restaurar producto") do
      tags :Products
      consumes "application/json"
      parameter(name: :product_id, in: :path, description: "Id del producto",
                schema: { "$ref" => "#/components/schemas/product_id" })
      security [Bearer: []]
      response(200, :successful) do
        let(:user) { create :owner }
        let(:user_token) { create :token, user: user }
        let(:product) { create :product, store: user.store, deleted_at: Time.now }
        let(:product_id) { product.id }
        let(:Authorization) { "Bearer #{user_token.token}" }
        run_test!
      end
    end
  end
end
