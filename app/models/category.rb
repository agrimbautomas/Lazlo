# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#  views              :integer          default(0)
#  description        :string
#

class Category < ApplicationRecord
  include Rails.application.routes.url_helpers

  extend FriendlyId

  friendly_id :name, use: :slugged

  before_save :parse_slug, :if => :name_changed?

  validates :name, presence: true, allow_blank: false,
				:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }
  validates :slug, presence: true, allow_blank: false,
				:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }
  validates :description, presence: true, allow_blank: false, length: { maximum: 160 }

  has_many :products

  has_attached_file :image,
						  styles: { big: "800x800>",
										medium: "450x300>",
										rectangular1: "488x288#",
										rectangular2: "584x286#",
										thumb: "100x100>" },
						  default_url: "/images/:style/missing.png", :preserve_files => true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def parse_slug
	 self.slug = self.name.downcase.strip.gsub(' ', '-').gsub('ñ', 'n').gsub(/[^\w-]/, '')
	 self.slug = self.slug + rand(0..9999).to_s if Category.find_by_slug(self.slug).present?
  end


end
