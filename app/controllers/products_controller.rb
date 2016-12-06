class ProductsController < ApplicationController
	before_action :authenticate_admin!, only: [:create, :update, :destroy, :new, :edit]
	def index
		if params["show"] == "discount"
			@products = Product.where("price < ?", 5)
		elsif params["search"]
			@products = Product.where("name ILIKE ?", "%#{params["search"]}%")
		elsif params["category"]
			category = Category.find_by(name: params["category"])
			@products = category.products
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
		@product = Product.find(@id)
		@supplier = Supplier.find(@product.supplier_id)
		# @images = Image.where(product_id: @product.id)
		render 'show.html.erb'
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(
			name: params["name"],
			price: params["price"],
			description: params["description"],
			supplier_id: params["Product"]["supplier_id"],
			user_id: session[:user_id]
		)
		
		if @product.save
			flash[:success] = "You added a new product!"
			redirect_to "/products/#{@product.id}"
		else
			render 'new.html.erb'
		end
	end

	def edit
		@product = Product.find_by(id: params["id"])
	end

	def update
		@product = Product.find_by(id: params["id"])
		if @product.update(
			name: params["name"],
			price: params["price"],
			description: params["description"],
			supplier_id: params["Product"]["supplier_id"]
		)
			flash[:success] = "You updated a product!"
			redirect_to "/products/#{@product.id}"
		else
			render 'edit.html.erb'
		end
	end

	def destroy
		product = Product.find_by(id: params["id"])
		product.destroy
		flash[:danger] = "You deleted a product!"
		redirect_to "/products"
	end
end
