require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create(email:'umair@gmail.com',password:'123123') }
  let(:other_user) { User.create(email:'ali@gmail.com',password:'123123') }
  let(:product) { user.products.create(name:'smart phone',description:'vivo smart phone') }
  let(:other_product) {  other_user.products.create(name:'laptop',description:'lenovo thinkpad')  }

  describe "#destroy" do
    context "when user tries to destroy their own product" do
      before do
        sign_in user 
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "destroys the product" do
        delete :destroy, params: { id: product.id }
        expect(response).to have_http_status(:no_content)
        expect { product.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when user tries to destroy other user's product" do
      before do
        sign_in user 
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "does not destroy the product" do
        delete :destroy, params: { id: other_product.id }
        expect(response).to have_http_status(:forbidden)
        expect { other_product.reload }.not_to raise_error
      end
    end
  end
end
