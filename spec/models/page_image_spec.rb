# == Schema Information
#
# Table name: page_images
#
#  id                   :integer          not null, primary key
#  caption              :string(255)
#  page_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe PageImage, type: :model do

  it { should respond_to (:page) }
  it { should respond_to (:picture) }

  it { should belong_to (:page) }

end
