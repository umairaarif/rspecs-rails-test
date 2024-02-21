require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
    describe 'DELETE #destroy' do
        let!(:product) {Product.create(name: 'watch',description: 'men hand watch')}
        let!(:user) { User.create(email: 'umair@gmail.com',password: '123123') }
        before do
            sign_in user 
        end
        scenario 'valid product attributes' do
        delete :destroy,params: {
          id: product.id
        }
        expect(response.status).to eq(200)
        
        end
    end
end