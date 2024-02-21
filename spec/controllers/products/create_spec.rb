require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "POST #create" do
  let!(:user) { User.create(email: 'umair@gmail.com',password: '123123') }
  before do
    sign_in user 
  end
    scenario "valid product attributes" do
      post :create, params: {
        product: {
          name: 'ring',
          description: 'golden ring'
        }
      }
      expect(response.status).to eq(201)
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:name]).to eq('ring')
      expect(json[:description]).to eq('golden ring')
      expect(Product.count).to eq(1)
      expect(Product.last.name).to eq('ring')
    end
    scenario "invalid product attributes" do
      post :create ,params: {
        product: {
          name: '',
          description: 'golden ring'
        }
      }
      expect(response.status).to eq(422)
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:name]).to eq(["can't be blank"])
      expect(Product.count).to eq(0)
    end
  end
end
