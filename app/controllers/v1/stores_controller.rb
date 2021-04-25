module V1
    class StoresController < ApplicationController
        before_action :authenticate_user!
        before_action :set_store
        
        def show; end

        private 
        def set_store
            if @current_user.store_id.to_s == params[:id]
                @store = @current_user.store
            else
                head :unauthorized
            end
        end
    end
end