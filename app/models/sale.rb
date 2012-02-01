class Sale < ActiveRecord::Base

	belongs_to :shop

	attr_accessor :start_delay
	attr_accessor :end_delay

	def timers
		@start_delay = self.start
		@end_delay = self.end
		start_sale
		end_sale
	end

	def start_sale
		@shop = Shop.find(self.shop_id)

		ShopifyAPI::Session.temp(@shop.name, @shop.token) do
			sale = ShopifyAPI::Variant.find(self.variant)
			sale.compare_at_price = sale.price
			sale.price = self.price
			sale.save
		end
	end
	handle_asynchronously :start_sale, :run_at => Proc.new { |s| s.start_delay }

	def end_sale
		@shop = Shop.find(self.shop_id)

		ShopifyAPI::Session.temp(@shop.name, @shop.token) do
			sale = ShopifyAPI::Variant.find(self.variant)
			sale.price = sale.compare_at_price
			sale.compare_at_price = nil
			sale.save
		end
	end
	handle_asynchronously :end_sale, :run_at => Proc.new { |s| s.end_delay }

	validates :product, :presence => true
  	validates :variant, :presence => true
  	validates :price, :presence => true
  	validates :start, :presence => true, :date => { :after => Time.now }
  	validates :end, :presence => true, :date => { :after => :start }

end 