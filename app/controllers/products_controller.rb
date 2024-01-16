class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def show
    render json: @product
  end

  def index
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 20).to_i

    @products = if params[:q].present?
                  Product.search(
                    params[:q],
                    where: filter_params,
                    order: order_params,
                    page: page, per_page: per_page
                  )
                else
                  Product.search(
                    where: filter_params,
                    order: order_params,
                    page: page, per_page: per_page
                  )
                end

    render json: @products
  end

  def autocomplete
    render json: Product.search(
                    params[:q],
                    fields: [:name, :brand],
                    match: :word_start,
                    limit: 10,
                    load: false,
                    misspellings: { below: 5 }
                  ).map {|p| { brand: p.brand, name: p.name } }
  end

  def suggestion
    @suggestions = Product.search(params[:q], suggest: true).suggestions
    
    render json: @suggestions
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def filter_params
    filters = {}
    
    filters[:category] = params[:category].split(',') if params[:category].present?
    filters[:brand] = params[:brand].split(',') if params[:brand].present?
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
