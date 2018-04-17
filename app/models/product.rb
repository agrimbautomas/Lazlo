# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  price              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  category_id        :integer
#  views              :integer          default(0)
#  featured           :boolean          default(FALSE)
#  visible            :boolean          default(TRUE)
#  deleted_at         :datetime
#

class Product < ApplicationRecord

  acts_as_paranoid

  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :category
  has_many :orders
  has_many :product_images, :dependent => :destroy
  has_many :product_rows

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  validates :name, presence: true, allow_blank: false,
				:uniqueness => {:case_sensitive => false}, length: {maximum: 255}

  validates_presence_of :price, :slug
  validates_numericality_of :price, greater_than_or_equal_to: 0

  before_save :parse_slug, :if => :name_changed?

  has_attached_file :image,
                    styles: {
											big: "800x800#",
											medium: "300x300#",
											square1: "400x400#",
											rectangular1: "584x288#",
											rectangular2: "544x350#",
											rectangular3: "454x284#",
											rectangular4: "350x400#",
											rectangular5: "356x284#",
											thumb: "162x162#"
										},
                    default_url: "/images/:style/missing.png", :preserve_files => true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  scope :featured, -> { limit(6).order('featured desc, views desc') }

  scope :visible, -> { where(:visible => true) }

  def image_uri
    URI.join($request.url, self.image.url)
  end

  private
  def parse_slug
    self.slug = self.name.downcase.strip.gsub(' ', '-').gsub('ñ', 'n').gsub(/[^\w-]/, '')
    self.slug = self.slug + rand(0..9999).to_s if Product.find_by_slug(self.slug).present?
  end

end
