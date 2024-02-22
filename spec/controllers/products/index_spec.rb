require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#index" do
    context "when user can read own products" do
      let(:admin) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'admin') }
      let!(:user_product) { admin.products.create(name:'watch',description:'hand watch') }
      let!(:other_product) { Product.new }

      before do
        sign_in admin
        ability = Ability.new(admin)
        allow(controller).to receive(:current_ability).and_return(ability)
        get :index
      end

      it "returns only products that the user can read" do
        expect(assigns(:products)).to include(user_product)
        expect(assigns(:products)).not_to include(other_product)
        expect(response).to have_http_status(:success)
      end

    end

    context "when user cannot read other products" do
      let(:admin) { User.create(email:'ali@gmail.com',password:'123123',user_type: 'admin') }
      let(:employee) { User.create(email:'umair@gmail.com',password:'123123',user_type: 'employee') }
      let!(:user_product1) { admin.products.create(name:'watch',description:'hand watch') }
      let!(:user_product2) { employee.products.create(name:'phone',description:'vivo mobile phone') }

      before do
        sign_in admin
        ability1 = Ability.new(admin)
        ability1.can :manage, Product,user: admin
        allow(controller).to receive(:current_ability).and_return(ability1)
        get :index
      end
       before do
        sign_in employee
        ability2 = Ability.new(employee)
        ability2.can :read, Product,user: employee
        allow(controller).to receive(:current_ability).and_return(ability2)
        get :index
      end

      it "returns an empty collection" do
        expect(assigns(:products)).to include(user_product2)
        expect(response).to have_http_status(:success)
      end

    end
  end
end
