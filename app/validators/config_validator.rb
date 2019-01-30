class ConfigValidator < ActiveModel::Validator
	def validate( record )
		record.errors[:picture] <<
				"Es necesario cargar una imagen" if config_needs_image? record

		record.errors[:product] <<
				"Es necesario un producto" if config_needs_product? record
	end

	def config_needs_image?( record )
		record.config_type != "most_liked_product" and record.picture.blank?
	end

	def config_needs_product?( record )
		record.config_type == "most_liked_product" and record.product.blank?
	end

end
