class ProductsController < ApplicationController

	around_filter :shopify_session

	respond_to :html, :json

 	def get_variants
    	@variants = ShopifyAPI::Product.find(params[:product])
    	respond_with(@variants)
  	end

end