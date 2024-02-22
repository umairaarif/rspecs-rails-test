require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'admin')  }
  let(:employee) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'employee')  }

  describe "#create" do
    context "when user is logged in" do
      before do
        sign_in user 
        allow(controller).to receive(:current_user).and_return(user)

      end

      it "creates a product associated with the current user" do
        post :create, params: { product: { name: "Test Product", description: "Test Description" } }
        expect(response).to have_http_status(:created)
        expect(Product.count).to eq(1)
        expect(Product.last.user).to eq(user)
      end
    end

    context "when employee is logged in" do
      before do
        sign_in employee 
        allow(controller).to receive(:current_user).and_return(employee)

      end
      it "employee does not create a product" do
        post :create, params: { product: { name: "Test Product", description: "Test Description" } }
        expect(response).to have_http_status(302)
        expect(Product.count).to eq(0)
      end
    end
  end
end
