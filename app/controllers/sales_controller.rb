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
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale         = Sale.new
    @sale.product = params[:product]
    @sale.variant = params[:variant]
    @sale.start   = Time.parse(params[:start_date] + params[:start_time])
    @sale.end     = Time.parse(params[:end_date] + params[:end_time])
    @sale.price   = params[:sale_price]
    @sale.shop_id = Shop.find_by_name(session[:shop_name]).id

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render json: @sale, status: :created, location: @sale }
      else
        format.html { render action: "new" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
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
