class Sale < ActiveRecord::Base
  	belongs_to :shop

  	validates :product, :presence => true
  	validates :variant, :presence => true
  	validates :price, 	:presence => true
  	validates :start, 	:presence => true
  	validates :end,		:presence => true

end 