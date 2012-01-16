class LoginController < ApplicationController
  def index
    # Ask user for their #{shop}.myshopify.com address
    
    # If the #{shop}.myshopify.com address is already provided in the URL, just skip to #authenticate
    if params[:shop].present?
      redirect_to authenticate_path(:shop => params[:shop])
    end

    render :layout => 'login'
  end

  def authenticate
    if params[:shop].present?
      redirect_to ShopifyAPI::Session.new(params[:shop].to_s.strip).create_permission_url
    else
      redirect_to return_address
    end
  end
  
  # Shopify redirects the logged-in user back to this action along with
  # the authorization token t.
  # 
  # This token is later combined with the developer's shared secret to form
  # the password used to call API methods.
  def finalize
    shopify_session = ShopifyAPI::Session.new(params[:shop], params[:t], params)
    if shopify_session.valid?
      session[:shopify] = shopify_session
      session[:shop_name] = params[:shop]

      shop = Shop.find_or_create_by_name_and_api_url(params[:shop], shopify_session.site)

      flash[:notice] = "Successfully syncronchized with your Shopify store. Go ahead and create a new sale!"

      redirect_to return_address
      session[:return_to] = nil
    else
      flash[:error] = "Could not log in to Shopify store."
      redirect_to :action => 'index'

    end
  end
  
  def logout
    session[:shopify] = nil
    session[:shop_name] = nil
    reset_session
    flash[:notice] = "Successfully logged out."
    
    redirect_to :action => 'index'
  end
  
  protected
  
  def return_address
    session[:return_to] || root_url

  end
end
