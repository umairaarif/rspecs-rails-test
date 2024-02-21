require "rails_helper"

RSpec.describe ProductsController, type: :controller do
    describe 'GET #index' do

        let!(:user) { User.create(email: 'umair@gmail.com',password: '123123') }
        before do
            sign_in user 
        end

        before do
            Product.create(name: "First name", description: "This is the first description")
            Product.create(name: "Second name", description: "This is the second description")
        end

        scenario "Sends a get request to get all product" do
                
            get :index

            expect(response.status).to eq(200)
            json = JSON.parse(response.body)
            expect(json.count).to eq(2)
        end
    end
end