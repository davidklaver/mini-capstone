class ProductsController < ApplicationController
	def index
		if params["show"] == "discount"
			@products = Product.where("price < ?", 5)
		elsif params["search"]
			@products = Product.where("name ILIKE ?", "%#{params["search"]}%")
		else
			@products = Product.all
		end

		if params["sort_by"] && params["order"]
			@products = @products.order(params["sort_by"] => params["order"])
		end
		# @message = params["key"]
	end

	def show
		if params["id"] == "rand"
			@id = Product.offset(rand(Product.count)).first.id
			# The following is simpler, but slower:
			# @id = Product.all.sample.id
		else
			@id = params["id"]
		end
		@product = Product.find_by(id: @id)
		@supplier = Supplier.find_by(id: @product.supplier_id)
		# @images = Image.where(product_id: @product.id)
		render 'show.html.erb'
	end

	def new
	end

	def create
		# p params["Product"]
		# p "*" * 50
		product = Product.create!(name: params["name"], price: params["price"], description: params["description"], supplier_id: params["Product"]["supplier_id"], user_id: session[:user_id])
		# product.save
		# add a flash message
		flash[:success] = "You added a new product!"
		redirect_to "/products/#{product.id}"
	end

	def edit
		@product = Product.find_by(id: params["id"])
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
