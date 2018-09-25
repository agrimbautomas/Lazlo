ActiveAdmin.register Buyer do
	menu priority: 3, parent: I18n.t('activerecord.models.user.other')

	permit_params :name, :email, :phone, :address, :category

	filter :name
	filter :email

	#
	# Config
	#
	Buyer.categories.each do |category|
		scope(Buyer.human_enum_name(:category, category.first)) do |scope|
			scope.where(category: category)
		end
	end

	index do
		selectable_column

		column :name
		column :email
		column :phone
		column :address
		column :category do |buyer|
			Buyer.human_enum_name(:category, buyer.category)
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
				Buyer.human_enum_name(:category, buyer.category)
			end

		end
	end

	csv do
		column :id
		column :name
		column :email
		column :phone
		column :address
		column :category do |object|
			Buyer.human_enum_name(:category, object.category)
		end
		column :created_at do |object|
			object.created_at&.strftime('%d/%m/%Y')
		end
	end

end