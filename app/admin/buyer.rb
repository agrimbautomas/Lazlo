ActiveAdmin.register Buyer do
  menu priority: 3

  permit_params :name, :email, :phone

  index do
    selectable_column

    column :name
    column :email
    column :phone
    column :address

    actions
  end
end
