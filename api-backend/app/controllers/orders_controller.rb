class OrdersController < ApplicationController
    before_action :set_user
    before_action :set_user_order, only: [:show, :update, :destroy]
    
    # GET /users/:user_id/orders
    def index
        json_response(@user.orders)
    end
    
    # GET /users/:user_id/orders/:id
    def show
        json_response(@order)
    end
    
    # POST /users/:user_id/orders
    def create
        @user.orders.create!(order_params)
        json_response(@order, :created)
    end
    
    # PUT /users/:user_id/orders/:id
    def update
        @order.update(order_params)
        head :no_content
    end
    
    # DELETE /users/:user_id/orders/:id
    def destroy
        @order.destroy
        head :no_content
    end
    
    private
    
    def order_params
        params.permit(:device, :imei, :yearly_price, :installments)
    end
    
    def set_user
        @user = User.find(params[:user_id])
    end
    
    def set_user_order
        @order = @user.orders.find_by!(id: params[:id]) if @user
    end
end
