require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#index" do
    context "when user can read own products" do
      let(:user) { User.create(email:'umair@gmail.com',password:'123123') }
      let!(:user_product) { user.products.create(name:'watch',description:'hand watch') }
      let!(:other_product) { Product.new }

      before do
        sign_in user
        ability = Ability.new(user)
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
      let(:user1) { User.create(email:'ali@gmail.com',password:'123123') }
      let(:user2) { User.create(email:'umair@gmail.com',password:'123123') }
      let!(:user_product1) { user1.products.create(name:'watch',description:'hand watch') }
      let!(:user_product2) { user2.products.create(name:'phone',description:'vivo mobile phone') }

      before do
        sign_in user1
        ability1 = Ability.new(user1)
        ability1.can :manage, Product,user: user1
        allow(controller).to receive(:current_ability).and_return(ability1)
        get :index
      end
       before do
        sign_in user2
        ability2 = Ability.new(user2)
        ability2.can :manage, Product,user: user2
        allow(controller).to receive(:current_ability).and_return(ability2)
        get :index
      end

      it "returns an empty collection" do
        expect(assigns(:products)).to include(user_product1)
        expect(response).to have_http_status(:success)
      end

    end
  end
end
