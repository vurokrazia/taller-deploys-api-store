require "swagger_helper"

RSpec.describe "v1/users", type: :request do
  path "/{locale}/v1/users/login" do
    parameter name: "locale", in: :path, type: :string, description: "locale"

    post("login usuario") do
      tags :Users
      consumes "application/json"
      parameter name: :payload, in: :body, description: "Json para login de usuario",
        schema: { "$ref" => "#/components/schemas/login_user" }
      response(200, "successful") do
        let(:locale) { "es" }
        let(:user) { create(:owner,password:"123456") }
        let(:payload) {
          { user: {
            email: user.email,
            password: "123456",
          } }
        }
        run_test!
      end
    end
  end

  path "/v1/users" do
    # You'll want to customize the parameter types...
    post("Registro de usuario") do
      tags :Users
      consumes "application/json"
      parameter name: :payload, in: :body, description: "json para crear el usuario",
        schema: { "$ref" => "#/components/schemas/user" }
      response(201, "successful") do
        let(:payload) {
          { user: {
            email: "test@test.com",
            password: "123456",
            age: 27,
            store_attributes: { name: "test" },
          } }
        }
        run_test!
      end
    end
  end
end
