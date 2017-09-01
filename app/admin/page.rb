ActiveAdmin.register Page do
  menu priority: 15, parent: I18n.t('config')

  permit_params :name, :description, page_images_attributes: [:id, :picture, :caption, :_destroy]
  config.sort_order = 'name_asc'
  config.per_page = 20

  filter :name


  actions :all


  index do
    selectable_column

    column :name
    column :updated_at

    actions
  end


  form do |f|
    inputs do
      f.input :name
      f.input :description
    end

    inputs I18n.t('activerecord.models.page_image.other') do
      f.has_many :page_images, new_record: true do |page_image|
        hint = (page_image.object.picture.file? ? image_tag(page_image.object.picture.url(:medium)) : 'De 1300x330 px si son para el slider Papin!')
        page_image.input :picture, :hint => hint
        page_image.input :_destroy, :as => :boolean, :required => false, :label => 'Borrar Imagen'
      end
    end

    actions
  end

  show do |page|

    panel I18n.t('activerecord.models.page.one') do

      attributes_table_for page do
        row :name
        row :description

        paginated_collection(page.page_images.order('created_at DESC').page(params[:page]).per(10)) do
          table_for(collection, sortable: false) do
            column :picture do |page_image|
              image_tag(page_image.picture.url(:medium))
            end
          end
        end

        div raw('&nbsp;')
      end

    end


  end

end
