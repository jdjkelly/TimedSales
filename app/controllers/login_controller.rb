class LoginController < ApplicationController
  def index
    redirect_to :controller => 'home', :action => 'index' if session[:shopify_session]
    # Ask user for their #{shop}.myshopify.com address
    
    # If the #{shop}.myshopify.com address is already provided in the URL, just skip to #authenticate
    if params[:shop].present?
      redirect_to authenticate_path(:shop => params[:shop])
    end
  end

  def authenticate
    if params[:shop].present?
      ShopifyAPI::Session.setup({api_key: ENV["SHOPIFY_API_KEY"], secret: ENV["SHOPIFY_SHARED_SECRET"]})
      redirect_to "https://#{params[:shop].to_s}.myshopify.com/admin/oauth/authorize?client_id=#{ENV["SHOPIFY_API_KEY"]}&scope=read_products,write_products&redirect_uri=#{shopify_redirect_url}"
    else
      redirect_to return_address
    end
  end
  
  # Shopify redirects the logged-in user back to this action along with
  # the authorization code - which we need to exchange for a real token.
  def finalize
    if check_signature(params.except(:action, :controller)) # We only need the request params for this method - not the internal ones Rails uses

      response = RestClient.post "https://#{params[:shop]}/admin/oauth/access_token", client_id: ENV["SHOPIFY_API_KEY"], client_secret: ENV["SHOPIFY_SHARED_SECRET"], code: params[:code]

      token = ActiveSupport::JSON.decode(response)["access_token"]
      session[:shopify_session] = ShopifyAPI::Session.new(params[:shop], token)
      if session[:shopify_session].valid?  # returns true

        ShopifyAPI::Base.activate_session(session[:shopify_session])
        set_current_shop

        name = ShopifyAPI::Shop.current.name
        api_url = ShopifyAPI::Shop.current.myshopify_domain
        timezone = ShopifyAPI::Shop.current.timezone.scan(/(\W...\W\d+\W\d+\W) (\w.+)/)[0][1]
        shopify_id = ShopifyAPI::Shop.current.id

        Shop.find_or_create_by_name_and_api_url_and_token_and_timezone_and_shopify_id(name, api_url, token, timezone, shopify_id)

        flash[:notice] = "Successfully syncronchized with your Shopify store. Go ahead and create a new sale!"
        redirect_to :controller => 'home', :action => 'index'
      end
    else
      flash[:error] = "Could not log in to Shopify store."
      redirect_to :action => 'index'

    end
  end
  
  def logout
    session[:shopify_session] = nil
    reset_session
    flash[:notice] = "Successfully logged out."
    
    redirect_to :action => 'index'
  end
  
  protected
  
  def return_address
    session[:return_to] || root_url

  end

  def check_signature(params)
    if params[:code].present? && params[:shop].present? && params[:timestamp].present? && params[:signature].present?
      response_signature = params[:signature]

      params.delete(:signature)

      calculated_signature = params.collect { |k, v| "#{k}=#{v}" } # => ["shop=some-shop.myshopify.com", "timestamp=1337178173", "code=a94a110d86d2452eb3e2af4cfb8a3828"]
      calculated_signature = calculated_signature.sort # => ["code=25e725143c2faf592f454f2949c8e4e2", "shop=some-shop.myshopify.com", "timestamp=1337178173
      calculated_signature = calculated_signature.join # => "code=a94a110d86d2452eb3e2af4cfb8a3828shop=some-shop.myshopify.comtimestamp=1337178173"
      calculated_signature = Digest::MD5.hexdigest(ENV["SHOPIFY_SHARED_SECRET"] + calculated_signature) # => "25e725143c2faf592f454f2949c8e4e2"

      calculated_signature == response_signature
    end
  end
end
