class HomeController < ApplicationController
  
  around_filter :shopify_session
  
  def index
    # get 250 products
    @products 		= ShopifyAPI::Product.find(:all, :params => {:limit => 250})
    @sales 			= Sale.find_all_by_shop_id(Shop.find_by_name(session[:shop_name]).id)
    # @sales = Sale.find(:all)
  end
  
end