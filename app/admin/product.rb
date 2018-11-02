ActiveAdmin.register Product do
	menu priority: 1, parent: I18n.t('activerecord.models.product.other')

	permit_params :name, :slug, :description, :category_id, :image, :featured, :visible,
		product_sizes_attributes: [:id, :name, :price, :_destroy],
		product_images_attributes: [:id, :picture, :_destroy]

	config.sort_order = 'name_asc'
	config.per_page = 50

	filter :name
	filter :featured
	filter :category

	controller do
		defaults :finder => :find_by_slug
	end

	#
	# Config
	#
	Category.all.each do |category|
		scope category.name do
			Product.where(:category => category)
		end
	end

	#
	# Index
	#
	index do
		selectable_column

		column :name
		column 'Categoria' do |product|
			product.category
		end
		column :image do |product|
			image_tag(product.image.url(:thumb), :class => 'product-thumb')
		end

		column :views
		column :visible
		actions
	end


	form do |f|
		f.inputs I18n.t('activerecord.attributes.product.description') do
			f.input :name
			f.input :description
			f.input :category_id, :as => :select, include_blank: false,
				collection: Category.all, label: 'Tipo de producto'
			f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
			f.input :featured
			f.input :visible
		end

		inputs 'Medidas' do
			f.has_many :product_sizes, new_record: true do |product_size|
				f.semantic_errors *f.object.errors.keys
				product_size.input :name, :hint => 'Nombre de la medida como referencia, ej: 100cm x 150cm'
				product_size.input :price, :hint => 'Precio del producto en esta medida'
				product_size.input :_destroy, :as => :boolean, :required => false, :label => 'Borrar medida'
			end
		end

		inputs 'Galería de Imágenes' do
			f.has_many :product_images, new_record: true do |product_image|
				f.semantic_errors *f.object.errors.keys
				hint = (product_image.object.picture.file? ? image_tag(product_image.object.picture.url(:medium)) : 'De por lo menos 500x500 px así se ven bien Flannn!')
				product_image.input :picture, :hint => hint
				product_image.input :_destroy, :as => :boolean, :required => false, :label => 'Borrar Imagen'
			end
		end

		actions
	end

	show do |product|

		attributes_table_for product do
			row :name
			row 'Link' do
				link_to product_url, product_path
			end
			row :description
			row 'Tipo de producto' do
				Category.find(product.category_id).name
			end
			row :views
			row :featured
			row :visible
			row :image do
				image_tag(product.image.url(:medium))
			end

			panel 'Medidas' do
				table_for(product.product_sizes) do

					column t('activerecord.attributes.product_sizes.name') do |product_size|
						product_size.name
					end

					column t('activerecord.attributes.product_sizes.price') do |product_size|
						product_size.price
					end

				end
			end

			panel '' do
				table_for(product.product_images.order('created_at DESC')) do
					column 'Imágenes de la Galería' do |product_image|
						image_tag(product_image.picture.url(:medium))
					end
				end
			end

			div raw('&nbsp;')

		end
	end

end
