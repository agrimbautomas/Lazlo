ActiveAdmin.register UserContact  do
  menu priority: 2, parent: I18n.t('activerecord.models.user.other')

  permit_params :name, :email, :message


  filter :name
  filter :email

  index do
    selectable_column

    column :id
    column :name
    column :email

    column 'Fecha de creación' do |user|
      user.created_at.strftime('%H:%M %d/%m/%Y')
    end

    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
      f.input :message
    end
    f.actions
  end

  show do |buyer|
    attributes_table_for buyer do
      row :name
      row :email
      row :message
    end

  end


  csv do
    column :id
    column :name
    column :email
    column :message
    column :created_at do |object|
      object.created_at&.strftime('%d/%m/%Y')
    end
  end


end
