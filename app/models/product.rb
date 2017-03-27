class Product < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :category
  has_many :orders
  has_many :product_images, :dependent => :destroy
  has_many :product_rows

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  validates :name, presence: true

  before_save :parse_slug, :if => :name_changed?

  has_attached_file :image,
                    styles: {big: "800x800#", medium: "300x300#", thumb: "100x100#"},
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
            'pending' => product_purchase_success_url(self),
            'success' => product_purchase_pending_url(self),
            'failure' => product_purchase_failure_url(self)
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

  def parse_slug
    self.slug = self.name.downcase.strip.gsub(' ', '-').gsub('ñ', 'n').gsub(/[^\w-]/, '')
    self.slug = self.slug + rand(0..9999).to_s if Product.find_by_slug(self.slug).present?
  end


end
