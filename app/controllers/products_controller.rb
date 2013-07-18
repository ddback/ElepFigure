class ProductsController < ApplicationController
    def search
        products_response = JSON.parse(Products.new.get_products(params[:name]))
        search_response = products_response["products_search_response"]
        search_count = search_response["total_results"]
        @products = search_response["products"]["product"]
    end
end
