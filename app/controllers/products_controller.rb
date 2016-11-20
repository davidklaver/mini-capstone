class ProductsController < ApplicationController
	def index
		if params["sort"] == "asc"
			@products = Product.order(:price)
		elsif params["sort"] == "desc"
			@products = Product.order(price: :desc)
		elsif params["show"] == "discount"
			@products = Product.where("price < ?", 5)
		elsif params["sort"] == "name"
			@products = Product.order(:name)
		else
			@products = Product.all
		end
		# @message = params["key"]
		render 'index.html.erb'
	end

	def show
		@id = params["id"]
		@product = Product.find_by(id: @id)
		render 'show.html.erb'
	end

	def new
		render 'new.html.erb'
	end

	def create
		product = Product.new(name: params["name"], price: params["price"], image: params["image"], description: params["description"])
		product.save
		# add a flash message
		flash[:success] = "You added a new product!"
		redirect_to "/products/#{product.id}"
	end

	def edit
		@product = Product.find_by(id: params["id"])
		render 'edit.html.erb'
	end

	def update
		product = Product.find_by(id: params["id"])
		product.update(name: params["name"], price: params["price"], image: params["image"], description: params["description"])
		flash[:info] = "You updated a product!"
		redirect_to "/products/#{product.id}"
	end

	def destroy
		product = Product.find_by(id: params["id"])
		product.destroy
		flash[:danger] = "You deleted a product!"
		redirect_to "/products"
	end
end
