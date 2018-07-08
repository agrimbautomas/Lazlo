ActiveAdmin.register SiteConfig do
	menu priority: 15, parent: I18n.t('config')

	permit_params :picture, :caption, :_destroy
	config.sort_order = 'caption_asc'
	config.per_page = 20

	filter :caption


	actions :all


	index do
		selectable_column

		column :caption
		column :updated_at

		actions
	end


	form do |f|
		inputs do
			f.input :caption
			f.input :picture
		end

		inputs I18n.t('activerecord.models.site_config.other') do
		end

		actions
	end

	show do |site_config|

		h4 I18n.t('activerecord.models.site_config.one')

		attributes_table_for site_config do

		end

	end

end
