class CategoriesController < ApplicationController

  before_action :set_request, :set_category, :set_meta_data

  def show
	 @products = Product.visible.where(category_id: @category)
  end

  def set_request
	 $request = request
  end

  private
  def set_category
	 @category = Category.friendly.find(params[:id])
	 @category.update_attribute(:views, @category.views + 1)
  end

  def set_meta_data
	 set_og_tags @category.name,
					 @category.description,
					 resource_absolute_path(@category.image.url(:medium))
  end

end
