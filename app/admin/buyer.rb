ActiveAdmin.register Buyer do
	menu priority: 3, parent: I18n.t('activerecord.models.user.other')

	permit_params :name, :email, :phone, :address, :category

	filter :name
	filter :email

	index do
		selectable_column

		column :name
		column :email
		column :phone
		column :address
		column :category do |buyer|
			I18n.t("activerecord.attributes.buyer.categories.#{buyer.category}")
		end

		actions
	end

	form do |f|
		f.inputs do
			f.input :name
			f.input :email
			f.input :phone
			f.input :address
			f.input :category, include_blank: false
		end

		actions
	end


	show do |buyer|
		attributes_table_for buyer do
			row :name
			row :email
			row :phone
			row :address
			row :category do
				I18n.t("activerecord.attributes.buyer.categories.#{buyer.category}")
			end

		end
	end


end
