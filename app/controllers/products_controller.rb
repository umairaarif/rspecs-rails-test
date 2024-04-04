class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
      @products = Product.accessible_by(current_ability)
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
    @product = current_user.products.new(product_params)
    authorize! :create ,@product
    if @product.save
      render json: @product, status: :created
    else 
      render json: @product.errors, status: 302
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
      render status: :no_content
    else
      render json: {error: 'Error deleting product'},status: 302
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description)
  end
end
