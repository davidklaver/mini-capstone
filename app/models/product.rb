class Product < ApplicationRecord
	belongs_to :supplier
	belongs_to :user
	has_many :images
	has_many :orders
	has_many :categorized_products
	has_many :categories, through: :categorized_products
	def sale_message
		if price.to_i < 2
			message = "Discount Item!"
		else
			message = "On Sale!"
		end
		message
	end

	def tax
		price * 0.09
	end

	def total
		price + tax
	end
	def discount
		if price < 2
			add_class = "redFont"
		else
			add_class = ""
		end
		add_class
	end

end
