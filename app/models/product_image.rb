# == Schema Information
#
# Table name: product_images
#
#  id                   :integer          not null, primary key
#  product_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class ProductImage < ActiveRecord::Base
  belongs_to :product

  has_attached_file :picture,
                    styles: {slider: "1300x330#", big: "800x800>", medium: "300x300>", thumb: "100x100>"},
                    default_url: "/images/:style/missing.png", :preserve_files => true

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

end
