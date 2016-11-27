class OrdersController < ApplicationController

def create
		product = Product.find(params["product_id"])
		quantity = params["quantity"].to_i
		subtotal = product.price * quantity
		tax = product.tax * quantity
		total = subtotal + tax
  	order = Order.create!(
  		user_id: current_user.id, 
  		quantity: quantity, 
  		product_id: params["product_id"], 
  		subtotal: subtotal, 
  		tax: tax, 
  		total: total
  		)
  	flash[:success] = "You've ordered this product!"
  	# redirect_to "/orders/#{product.id}"
  	redirect_to "/orders/#{order.id}" 
  end

  def show
  	@order = Order.find_by(id: params["id"])
  end
end
