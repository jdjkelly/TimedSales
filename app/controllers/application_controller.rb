class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_shop

  def shopify_redirect_url
    if Rails.env.production?
      "http://timedsales.com/login/finalize"
    else
      "http://localhost:3000/login/finalize"
    end
  end

  def check_shopify_session
    redirect_to :controller => 'login', :action => 'index' unless session[:shopify_session]
  end

  def set_current_shop
    @current_shop = session[:shopify_session] if session[:shopify_session]
  end
end
