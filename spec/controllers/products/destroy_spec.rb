require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:admin) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'admin') }
  let(:employee) { User.create(email:'ali@gmail.com',password:'123123',user_type:'employee') }
  let(:product) { admin.products.create(name:'smart phone',description:'vivo smart phone') }
  let(:other_product) {  employee.products.create(name:'laptop',description:'lenovo thinkpad')  }

  describe "#destroy" do
    context "when user tries to destroy their own product" do
      before do
        sign_in admin 
        allow(controller).to receive(:current_user).and_return(admin)

      end

      it "destroys the product" do
        delete :destroy, params: { id: product.id }
        expect(response).to have_http_status(:no_content)
        expect { product.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when user tries to destroy other user's product" do
      before do
        sign_in admin 
        allow(controller).to receive(:current_user).and_return(admin)
        
      end

      it "does not destroy the product" do
        delete :destroy, params: { id: other_product.id }
        expect(response).to have_http_status(302)
        expect { other_product.reload }.not_to raise_error
      end
    end
  end
end
