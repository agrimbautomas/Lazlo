# == Schema Information
#
# Table name: order_statuses
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  priority           :integer
#  visible            :boolean          default(TRUE)
#

class OrderStatus < ApplicationRecord

  has_attached_file :image, styles: {medium: "400x400>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true, allow_blank: false,
				:uniqueness => {:case_sensitive => false}, length: {maximum: 50}

  validates :priority, presence: true, uniqueness: true
  validates_numericality_of :priority, less_than: 100, greater_than: 0

  scope :visible, -> {where(:visible => true)}

  def name_slug
	 self.name.parameterize
  end

end
