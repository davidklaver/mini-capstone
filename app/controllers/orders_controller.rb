class OrdersController < ApplicationController
before_action :authenticate_user!
def create
# i) Find all of the current user’s products that have a status of “carted”.
  carted_products = current_user.carted_products.where("status = ?", "carted")
# ii) Use that data to create a new row in the orders table, and save the user_id, subtotal, tax, and total.
  	order1 = Order.create(user_id: current_user.id)
  
    # iii) Modify all the rows from the carted_products table so that their status changes to “purchased” and that they are given the appropriate order_id.

    carted_products.each do |carted_product|
      carted_product.update(status: "purchased", order_id: order1.id)
    end

    order1.update(subtotal: order1.order_subtotal, tax: order1.order_tax, total: order1.order_total)

  	flash[:success] = "Your order has been placed!"
  	redirect_to "/orders/#{order1.id}" 
  end

  def show
  	@order = Order.find(params["id"])
    redirect_to "/products" unless current_user.admin || current_user.id == @order.user_id
  end
end
