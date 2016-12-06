class Order < ApplicationRecord
	belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  def pretty_time
  		created_at.strftime("%A, %b %d")
	end

	def order_subtotal
		subtotal = 0
		carted_products.each do |carted_product|
			subtotal += carted_product.product.price * carted_product.quantity
		end
		subtotal
	end

	def order_tax
		tax = order_subtotal * 0.09
		tax
	end

	def order_total
		total = order_subtotal + order_tax
		total
	end
end
