class Product < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :category
  has_many :orders

  validates :name, presence: true

  has_attached_file :image,
                    styles: {big: "800x800>", medium: "300x300>", thumb: "100x100>"},
                    default_url: "/images/:style/missing.png", :preserve_files => true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def payment
    preference_data = {
        'items' => [
            'title' => self.name,
            'description' => self.description,
            'quantity' => 1,
            'unit_price' => self.price,
            'currency_id' => 'ARS',
            'picture_url' => self.image_uri
        ],
        'back_urls' => {
            'pending' => product_purchase_success_path(self),
            'success' => product_purchase_pending_path(self),
            'failure' => product_purchase_failure_path(self)
        }
    }

    $mp_client.create_preference(preference_data)
  end

  def set_quantity quantity
    @quantity = quantity
  end

  def image_uri
    URI.join($request.url, self.image.url)
  end


  def serializable_hash(*args)
    hash = super(*args)
    hash.delete("image_file_name")
    hash.delete("image_content_type")
    hash.delete("image_file_size")
    hash.delete("image_updated_at")
    hash[:image] = self.image.url(:big) unless self.image.nil?
    hash[:image] = self.image.url(:medium) unless self.image.nil?
    hash[:image] = self.image.url(:thumb) unless self.image.nil?
    hash
  end

end
