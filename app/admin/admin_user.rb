ActiveAdmin.register AdminUser do
  menu parent: I18n.t('activerecord.models.user.other')

  permit_params :email, :password, :password_confirmation, :role_ids


  filter :email

  index do
    selectable_column

    column :id
    column :email
    column 'Rol' do |adminUser|
      adminUser.roles.map(&:name).join(" - ").humanize
    end
    column :current_sign_in_at

    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :radio,
              collection: Role.all.map { |role| [role.name.humanize, role.id] }
    end
    f.actions
  end

  show do |buyer|
    attributes_table_for buyer do
      row :email
      row 'Rol' do |adminUser|
        adminUser.roles.map(&:name).join("<br />").humanize
      end
      row :sign_in_count
    end

  end


end
