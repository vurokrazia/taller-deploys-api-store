require "swagger_helper"

RSpec.describe "v1/products", type: :request do
  path "/v1/products/" do
    get("Listado de productos") do
      tags :Products
      consumes "application/json"
      security [Bearer: []]
      response(200, :successful) do
        let(:user) { create :owner }
        let(:user_token) { create :token, user:user }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let!(:products) { create_list(:product, 10, store: user.store) }
        run_test!
      end
    end
  end
end
