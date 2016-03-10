class Product < ActiveRecord::Base

  has_one :product_type

  validates :name, presence: true

  has_attached_file :image,
                    styles: { big: "800x800>", medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png", :preserve_files => true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


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
