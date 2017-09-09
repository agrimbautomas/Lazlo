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
#

class Product < ActiveRecord::Base
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
  validates_numericality_of :price, greater_than: 0

  before_save :parse_slug, :if => :name_changed?

  has_attached_file :image,
                    styles: {big: "800x800#", medium: "300x300#", thumb: "100x100#"},
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
