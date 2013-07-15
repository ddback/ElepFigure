class ProductsController < ApplicationController
    def search
        name = params[:name]
        @products = SyncProducts.get_products(name)
    end
end
