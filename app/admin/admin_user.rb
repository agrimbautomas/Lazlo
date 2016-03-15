ActiveAdmin.register AdminUser  do
  menu priority: 4

  permit_params :email, :password, :password_confirmation


  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  index do
    selectable_column

    column :id
    column :email
    column :created_at

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

end
