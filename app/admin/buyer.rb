ActiveAdmin.register Buyer do
  menu priority: 3

  permit_params :name, :email, :phone, :address

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
      f.input :name, :label => 'Nombre del Comprador'
      f.input :email
      f.input :phone, :label => 'Teléfono'
      f.input :address, :label => 'Dirección'
    end

    actions
  end


  show do |buyer|
    attributes_table_for buyer do
      row 'Nombre' do
        buyer.name
      end
      row :email
      row 'Teléfono' do
        buyer.phone
      end
      row 'Dirección' do
        buyer.address
      end

    end

  end

end
