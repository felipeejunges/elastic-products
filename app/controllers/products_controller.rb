class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def show
    render json: @product
  end

  def index
    @products = Product.search(
      params[:q],
      where: filter_params,
      order: order_params
    )

    render json: @products
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def filter_params
    filters = {}
    
    filters[:type] = params[:category].split(',') if params[:category].present?
    filters[:sizes] = params[:sizes].split(',') if params[:sizes].present?
    filters[:colors] = params[:colors].split(',') if params[:colors].present?
    filters[:tags] = params[:tags].split(',') if params[:tags].present?
    if params[:min_price].present? || params[:max_price].present?
      price = {}
      price[:gte] = params[:min_price] if params[:min_price].present?
      price[:lte] = params[:max_price] if params[:max_price].present?

      filters[:price] = price if price.present?
    end

    filters
  end

  def order_params
    order = {}

    if params[:order].present?
      case params[:order]
      when 'relevance'
        order[:_score] = :desc
      when 'price'
        order[:price] = params[:direction] || 'asc'
      end
    else
      # Default order by relevance
      order[:_score] = :desc
    end

    order
  end
end
