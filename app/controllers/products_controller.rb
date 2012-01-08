class ProductsController < ApplicationController

	around_filter :shopify_session

	def index
	    # get all products (defaults to 50)
	    @products = ShopifyAPI::Product.find(:all)
	end
  
	def show
		@product = ShopifyAPI::Product.find(params[:id])
	end
end
