class HomeController < ApplicationController
  	around_filter :shopify_session
  	def index
	    # get 250 products
	    @products 		= ShopifyAPI::Product.find(:all, :params => {:limit => 250})
	    @sales 			= Sale.find_all_by_shop_id(Shop.find_by_name(session[:shop_name]).id)
	    
	    if !@sales.nil? 
	    	# building a product name hash for existing sales data
	    	@product_names  = Hash.new
	    	 # building a variant name hash for existing sales data
	    	@variant_names  = Hash.new

		    @sales.each do |sale|
		    	local_product = sale.product
		    	local_variant = sale.variant
		    	if !@product_names.has_key?(local_product)
		    		api_response = ShopifyAPI::Product.find(local_product, :params => {:fields => "title"})
		    		@product_names[local_product] = api_response
		    	end

		    	if !@variant_names.has_key?(local_variant)
		    		api_response = ShopifyAPI::Variant.find(local_variant)
		    		@variant_names[local_variant] = api_response
		    	end
		    end
		    	
		end
	end
end