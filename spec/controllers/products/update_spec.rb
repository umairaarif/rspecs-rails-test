require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create(email:'umair@gmail.com',password:'123123') }
  let(:other_user) { User.create(email:'ali@gmail.com',password:'123123') }
  let(:product) {  user.products.create(name:'smart phone',description:'vivo smart phone')  }
  let(:other_product) {  other_user.products.create(name:'laptop',description:'lenovo thinkpad')  }

  describe "#update" do
    context "when user tries to update their own product" do
      before do
        sign_in user 
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "updates the product" do
        patch :update, params: { id: product.id, product: { name: "Updated Name" } }
        product.reload
        expect(product.name).to eq("Updated Name")
      end
    end

    context "when user tries to update other user's product" do
      before do
        sign_in user 
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "does not update the product" do
        patch :update, params: { id: other_product.id, product: { name: "Updated Name" } }
        other_product.reload
        expect(other_product.name).not_to eq("Updated Name")
      end
    end
  end
end
