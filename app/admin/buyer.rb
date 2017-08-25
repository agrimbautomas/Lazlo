ActiveAdmin.register Buyer do
  menu priority: 3, parent: I18n.t('activerecord.models.user.other')

  permit_params :name, :email, :phone, :address

  filter :name
  filter :email

  index do
    selectable_column

    column :name
    column :email
    column :phone
    column :address

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :address
    end

    actions
  end


  show do |buyer|
    attributes_table_for buyer do
      row :name
      row :email
      row :phone
      row :address

    end
  end


end
