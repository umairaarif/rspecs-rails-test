require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/products/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/products/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    scenario "valid product attributes" do
      post "/products",params: {
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
      post "/products",params: {
        product: {
          name: '',
          description: 'golden ring'
        }
      }
      expect(response.status).to eq(422)
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:description]).to eq(["can't be null"])
      expect(Product.count).to eq(0)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/products/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/products/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/products/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
