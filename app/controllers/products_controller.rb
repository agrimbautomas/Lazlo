class ProductsController < ApplicationController

  before_filter :set_request
  before_action :set_product, :set_meta_data

  def index
  end

  def show
	 @image_uri = URI.join(request.url, @product.image.url)
	 @category = Category.friendly.find(@product.category_id)
  end

  def set_request
	 $request = request
  end

  private
  def set_product
	 @product = Product.friendly.find(params[:id])
	 @product.update_attribute(:views, @product.views + 1)
  end

  def set_meta_data
	 set_og_tags @product.name,
					 @product.description.squish,
					 resource_absolute_path(@product.image.url(:medium))
  end

end
