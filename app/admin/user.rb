ActiveAdmin.register User do
  menu priority: 1, label: I18n.t('activerecord.models.user.app_users'),
	  parent: I18n.t('activerecord.models.user.other')


  index do
	 selectable_column

	 column :id
	 column :email do |user|
		 link_to user.email, admin_user_path(user)
	 end

	 column 'Última vez conectado' do |user|
		user.last_sign_in_at.strftime('%H:%M %d/%m/%Y') unless user.last_sign_in_at.nil?
	 end

	 column 'Registro' do |user|
		user.confirmation_token.nil? ? 'Facebook' : 'Página'
	 end

	 column 'Productos en carrito' do |user|
		user.checkout_list.present? ? user.checkout_list.products_count : 0
	 end

	 column 'Productos comprados' do |user|
		user.purchased_list.present? ? user.purchased_list.products_count : 0
	 end

	 actions
  end

  form do |f|
	 f.inputs "Admin Details" do
		f.input :email
		f.input :password
		f.input :password_confirmation
	 end
	 f.actions
  end

  show do |buyer|
	 attributes_table_for buyer do
		row :email
		row :sign_in_count
		row :last_sign_in_at do
		  buyer.last_sign_in_at.strftime('%H:%M %d/%m/%Y')
		end
		row :created_at do
		  buyer.created_at.strftime('%d/%m/%Y')
		end
	 end

	 panel 'Productos en el carrito' do
		table_for(buyer.checkout_list.product_rows) do

		  column t('activerecord.models.product.one') do |product_row|
			 # Show unless the product is deleted
			 link_to product_row.product.name, product_path(product_row.product) unless product_row.product.nil?
		  end

		  column t('quantity') do |product_row|
			 product_row.quantity unless product_row.product.nil?
		  end

		  column t('total') do |product_row|
			  format_price product_row.total unless product_row.product.nil?
		  end

		  column I18n.t('activerecord.models.product_image.one') do |product_row|
			 image_tag(product_row.product.image.url(:thumb)) unless product_row.product.nil? or product_row.product.image.nil?
		  end

		end
	 end unless buyer.checkout_list.nil?

  end


end
