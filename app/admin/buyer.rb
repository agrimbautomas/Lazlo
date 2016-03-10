ActiveAdmin.register Buyer do
  menu priority: 3

  permit_params :name, :email, :phone


end
