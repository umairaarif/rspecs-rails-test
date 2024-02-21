require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
    describe 'PATCH #update' do
        let!(:product) {Product.create(name: 'watch',description: 'men hand wacth')}
        let!(:user) { User.create(email: 'umair@gmail.com',password: '123123') }
        before do
            sign_in user 
        end
        scenario 'valid product attributes' do
            new_attributes = { name: 'Smartwatch', description: 'Digital smartwatch' }
            patch :update, params: { id: product.id, product: new_attributes }
            product.reload
            expect(product.name).to eq('Smartwatch')
            expect(product.description).to eq('Digital smartwatch')
            expect(response).to have_http_status(:ok)
        end

        context 'with invalid attributes' do
            it 'does not update the product' do
              patch :update, params: { id: product.id, product: { name: '' } }
              product.reload
              expect(product.name).to eq('watch')
              expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
