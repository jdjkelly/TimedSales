class HomeController < ApplicationController
  
  around_filter :shopify_session
  
  def index
    # get 250 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 250})
  end
  
end
