require 'rails_helper'

RSpec.describe 'Orders API' do
    let!(:user) { create(:user) }
    let!(:orders) { create_list(:order, 15, user_id: user.id) }
    let(:user_id) { user.id }
    let(:id) { orders.first.id }
    
    describe 'GET /users/:user_id/orders' do
        before { get "/users/#{user_id}/orders" }
        
        context 'when user exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
            
            it 'returns all user items' do
                expect(json.size).to eq(15)
            end
        end
        
        context 'when user does not exist' do
            let(:user_id) { 39 }
            
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end
    
    describe 'GET /users/:user_id/orders/:id' do
        before { get "/users/#{user_id}/orders/#{id}" }
        
        context 'when user item exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
            
            it 'returns the item' do
                expect(json['id']).to eq(id)
            end
        end
        
        context 'when todo item does not exist' do
            let(:id) { 39 }
            
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Order/)
            end
        end
    end
    
    describe 'POST /users/:user_id/orders' do
        let(:valid_attributes) { { device: 'Nokia 3310', imei: '000000-00-000000-0', yearly_price: 399.90, installments: 12, user_id: user_id } }
        
        context 'when request attributes are valid' do
            before { post "/users/#{user_id}/orders", params: valid_attributes }
            
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end
        
        context 'when request attributes are invalid' do
            before { post "/users/#{user_id}/orders", params: {} }
            
            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
            
            it 'returns a failure message' do
                expect(response.body).to match(/Device can't be blank/)
            end
        end
    end
    
    describe 'PUT /users/:user_id/orders/:id' do
        let(:valid_attributes) { { device: 'iPhone X' } }
        
        before { put "/users/#{user_id}/orders/#{id}", params: valid_attributes } 
        
        context 'when order exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
            
            it 'updates the order' do
                updated_order = Order.find(id)
                expect(updated_order.device).to match(/iPhone X/)
            end
        end
        
        context 'when order does not exist' do
            let(:id) { 39 }
            
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Order/)
            end
        end
    end
    
    describe 'DELETE /users/:user_id/orders/:id' do
        before { delete "/users/#{user_id}/orders/#{id}" }
        
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end