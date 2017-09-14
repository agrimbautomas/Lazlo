# == Schema Information
#
# Table name: order_statuses
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  priority           :integer
#  visible            :boolean          default(TRUE)
#

class OrderStatus < ActiveRecord::Base

  has_attached_file :image, styles: {medium: "400x400>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, uniqueness: true
  validates :priority, uniqueness: true

  before_validation :set_priority

  scope :visible, -> { where(:visible => true) }

  def name_slug
	 self.name.parameterize
  end

  def set_priority
	 self.priority = 1
	 if OrderStatus.order(priority: :asc).last.present?
		self.priority = OrderStatus.order(:priority).last.priority + 1
	 end
  end

end
