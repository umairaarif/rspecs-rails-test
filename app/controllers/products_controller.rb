class ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end
  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      render json: @product, status: :created
    else 
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      render status: :ok
    else
      render json: {error: 'Error deleting product'}
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description)
  end
end
