# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string(255)
#  category_id        :integer
#  views              :integer          default(0)
#  featured           :boolean          default(FALSE)
#  visible            :boolean          default(TRUE)
#  deleted_at         :datetime
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_deleted_at   (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class Product < ApplicationRecord

	acts_as_paranoid

	include Rails.application.routes.url_helpers

	extend FriendlyId
	friendly_id :name, use: :slugged

	belongs_to :category
	has_many :orders, :dependent => :destroy
	has_many :product_images, :dependent => :destroy
	has_many :product_rows, :dependent => :destroy
	has_many :favourites, :dependent => :destroy
	has_many :product_sizes, :dependent => :destroy


	accepts_nested_attributes_for :product_sizes, :allow_destroy => true
	accepts_nested_attributes_for :product_images, :allow_destroy => true


	validates_presence_of :slug, :name
	validates :product_sizes, :length => { :minimum => 1 }
	validates :name, allow_blank: false,
		:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }

	before_save :parse_slug, :if => :name_changed?

	has_attached_file :image,
		styles: {
			big: "800x800#",
			medium: "300x300#",
			rectangular1: "584x288#",
			rectangular2: "544x350#",
			rectangular3: "455x285#",
			rectangular4: "360x350#",
			rectangular5: "360x285#",
			rectangular6: "455x350#",
			thumb: "162x162#"
		},
		default_url: "/images/:style/missing.png", :preserve_files => true
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


	scope :featured, -> { limit(6).order('featured desc, views desc') }

	scope :visible, -> { where(:visible => true) }

	scope :most_viewed, -> { order('views DESC').first }

	#Todo Add suggestions logic
	scope :suggestions_for, -> (product) { where(:category => product.category).limit(7) }

	#Todo Remove
	def price
		9999
	end

	def image_uri
		URI.join($request.url, self.image.url)
	end

	private
	def parse_slug
		self.slug = self.name.downcase.strip.gsub(' ', '-').gsub('ñ', 'n').gsub(/[^\w-]/, '')
		self.slug = self.slug + rand(0..9999).to_s if Product.find_by_slug(self.slug).present?
	end

end
