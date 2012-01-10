class ProductsController < ApplicationController
	around_filter :shopify_session

  respond_to :html, :json, :js

  def get_variants
    @variants = ShopifyAPI::Product.find(params[:product])
    respond_with(@variants)
  end
  def get_pricing
    @pricing = ShopifyAPI::Product.find(params[:variant])
    respond_with(@pricing)
  end
end
