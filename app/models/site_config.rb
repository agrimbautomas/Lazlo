# == Schema Information
#
# Table name: site_configs
#
#  id                   :integer          not null, primary key
#  caption              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  config_type          :integer          not null
#  product_id           :bigint(8)
#
# Indexes
#
#  index_site_configs_on_product_id  (product_id)
#

class SiteConfig < ApplicationRecord

	belongs_to :product

	validates_presence_of :config_type
	validates :caption, presence: true, allow_blank: false, length: { maximum: 255 }
	validates_with ConfigValidator

	has_attached_file :picture,
		styles: {
			slider: "1400x695#",
			home_support: "680x670#",
			home_promotion: "555x350#",
			big: "800x800>",
			medium: "300x300>",
			thumb: "100x100>"
		},
		default_url: "/images/:style/missing.png", :preserve_files => true

	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

	enum config_type: {
			home_slide: 0,
			home_support: 1,
			home_promotion: 2,
			most_liked_product: 3
	}

end