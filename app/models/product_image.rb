class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :picture,
                    styles: {slider: "1300x330#", big: "800x800>", medium: "300x300>", thumb: "100x100>"},
                    default_url: "/images/:style/missing.png", :preserve_files => true

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

end
