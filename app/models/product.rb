class Product < ApplicationRecord
	belongs_to :supplier
	belongs_to :user, optional: true
	has_many :images
	has_many :categorized_products
	has_many :categories, through: :categorized_products
	has_many :carted_products
	has_many :users, through: :carted_products

	validates :name, presence: true
	validates :price, :numericality => {:greater_than => 0, :less_than => 1000}
	# validates :stock, presence: true

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
