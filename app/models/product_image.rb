# == Schema Information
#
# Table name: product_images
#
#  id                   :integer          not null, primary key
#  product_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class ProductImage < ApplicationRecord
  belongs_to :product

  has_attached_file :picture,
                    styles: {
								slider: "1300x330#",
								rectangular1: "1300x809#",
								rectangular2: "267x163#",
								big: "800x800>",
								medium: "300x300>",
								thumb: "100x100>"
						  },
                    default_url: "/images/:style/missing.png", :preserve_files => true

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

end
