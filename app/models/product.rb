class Product < ApplicationRecord
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
