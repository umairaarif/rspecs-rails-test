
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create(email:'umair@gmail.com',password:'123123') } 
  let(:product_params) { { name: 'Test Product', description: 'Test Description' } }

  describe "#create" do
    context "when user is authorized to create a product" do
      before { sign_in user }

      it "creates a new product" do
        expect {
          post :create, params: { product: product_params }
        }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "when user is not authorized to create a product" do
      it "returns unauthorize status" do
        post :create, params: { product: product_params }
        expect(response).to have_http_status(401)
      end
    end
  end
end
