class ProductsController < ApplicationController
	def all_products
		@all_products = Product.all
		render 'allproducts.html.erb'
	end
end
