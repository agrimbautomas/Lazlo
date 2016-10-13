ActiveAdmin.register User  do
  menu priority: 1, parent: I18n.t('activerecord.models.user.other')

  permit_params :email, :password, :password_confirmation, :role_ids


  filter :email

  index do
    selectable_column

    column :id
    column :email
    column :current_sign_in_at

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
    end

  end


end
