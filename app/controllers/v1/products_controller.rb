module V1
    class ProductsController < ApplicationController    
        before_action :authenticate_user!
        before_action :set_store
        def create
            @product = @store.products.new(product_params)
            if @product.valid?
                @product.save
                render :show, status: :created
            else
                render json: { errors: @product.errors.messages }, status: :bad_request
            end
        end
        private
        def product_params
            params.require(:product).permit(:name, :description, :price)
        end
        def set_store
            @store = @current_user.store
        end
    end
end