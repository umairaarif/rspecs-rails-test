require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #show' do
    let(:product) { Product.create(name: 'Ring', description: 'Golden ring') }
    let!(:user) { User.create(email: 'umair@gmail.com',password: '123123') }
      before do
          sign_in user 
      end
    context 'with valid product id' do
      it 'returns the product' do
        get :show, params: { id: product.id }
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json['name']).to eq(product.name)
        expect(json['description']).to eq(product.description)
      end
    end
    
    context 'with invalid product id' do
      it 'returns not found' do
        get :show, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
