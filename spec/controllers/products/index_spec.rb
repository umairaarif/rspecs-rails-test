require "rails_helper"

RSpec.describe "GET #index", type: :request do

    before do
        Product.create(name: "First name", description: "This is the first description")
        Product.create(name: "Second name", description: "This is the second description")

    end

    scenario "Sends a get request to get all product" do
            
        get "http://localhost:3000/products"

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json.count).to eq(2)
    end

end