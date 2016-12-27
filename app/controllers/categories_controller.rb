class CategoriesController < ApplicationController

  before_action :set_request, :set_category, :set_meta_data

  def show
    @products = Product.where(category_id: @category)
  end

  def set_request
    $request = request
  end

  private
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def set_meta_data
    set_og_tags @category.name, nil, resource_absolute_path(@category.image.url(:medium))
  end


end
