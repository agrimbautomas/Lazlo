ActiveAdmin.register SiteConfig do
	menu priority: 15, parent: I18n.t('config')

	permit_params :picture, :caption, :config_type, :_destroy
	config.sort_order = 'caption_asc'
	config.per_page = 20

	filter :caption


	actions :all


	index do
		selectable_column

		column :caption
		column :config_type
		column :updated_at
		column :picture do |site_config|
			image_tag(site_config.picture.url(:thumb), :class => 'product-thumb')
		end

		actions
	end


	form do |f|
		inputs do
			f.input :caption
			f.input :config_type
			f.input :picture
		end

		actions
	end

	show do |site_config|

		h4 I18n.t('activerecord.models.site_config.one')

		attributes_table_for site_config do
			row :caption
			row :config_type
			row :image do
				image_tag(site_config.picture.url(:medium))
			end
		end

	end

end
