require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:admin) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'admin') }
  let(:product) { admin.products.create(name:'laptop',description:'lenovo thinkpad') }

  describe "#show" do
    context "when user is authorized to view the product" do
      before do
        sign_in admin
        allow(controller).to receive(:current_user).and_return(admin)
       
      end

      it "returns the product" do
        get :show, params: { id: product.id }
        expect(response).to have_http_status(:success)
        expect(assigns(:product)).to eq(product)
      end
    end

    context "when user is not authorized to view the product" do
      it "returns unauthorize status" do
        get :show, params: { id: product.id }
        expect(response).to have_http_status(401)
      end
    end
  end
end
