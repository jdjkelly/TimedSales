class SalesController < ApplicationController

  around_filter :shopify_session

  respond_to :html, :json, :js

  # GET /sales/new
  # GET /sales/new.json
  def new
    @sale = Sale.new
    respond_with(@sale)
  end

  def show
    @sale = Sale.find(params[:id])

    @names = Hash.new
    if !@sale.nil? 
      product = @sale.product
      product_name = ShopifyAPI::Product.find(product, :params => {:fields => "title"})
      @names[product] = product_name

      variant = @sale.variant
      variant_name = ShopifyAPI::Variant.find(variant, :params => {:fields => "title"})
      @names[variant] = variant_name 
    end
  end

  # POST /sales
  # POST /sales.json
  def create
    #set time zone
    Time.zone = Shop.find_by_name(session[:shop_name]).timezone
    Chronic.time_class = Time.zone

    @sale         = Sale.new
    @sale.product = params[:product]
    @sale.variant = params[:variant]
    @sale.start   = Chronic.parse(params[:start_date] + " " + params[:start_time])
    @sale.end     = Chronic.parse(params[:end_date] + " " + params[:end_time])
    @sale.price   = params[:sale_price]
    @sale.shop_id = Shop.find_by_name(session[:shop_name]).id

    respond_to do |format|
      if @sale.save
        # queue up the sale in delayed_job
        @sale.timers
        
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render json: @sale, status: :created, location: @sale }
      else
        format.js { respond_with(@sale.errors) }
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    respond_with(@sale) do |format|
      format.js { render :nothing => true }
    end
  end

end
