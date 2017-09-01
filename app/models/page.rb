# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Page < ActiveRecord::Base
  has_many :page_images, :dependent => :destroy

  accepts_nested_attributes_for :page_images, :allow_destroy => true
end
