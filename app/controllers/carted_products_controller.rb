class CartedProductsController < ApplicationController
	before_action :authenticate_user!
	def index
		@carted_products = current_user.carted_products.where("status = ?", "carted")
		if @carted_products.count == 0
			redirect_to "/products"
		end
		@subtotal = 0
		@carted_products.each do |carted_product|
			@subtotal += carted_product.product_subtotal
		end
		@tax = @subtotal * 0.09
		@total = @subtotal + @tax
	end

	def create
		if params[:quantity] == nil
			quantity = 1
		else
			quantity = params["quantity"]
		end
		@carted_product = CartedProduct.new(
				status: "carted",
				user_id: current_user.id,
				product_id: params["product_id"],
				quantity: quantity
			)
		if @carted_product.save
			redirect_to "/carted_products"
		else
			@product = Product.find(params["product_id"])
			@supplier = @product.supplier
			render "/products/show.html.erb"
		end
	end

	def destroy
		carted_product = CartedProduct.find(params["id"])
		carted_product.update(status: "removed")
		flash[:warning] = "You have removed #{carted_product.product.name} from your cart."
		redirect_to "/carted_products"
	end
end
