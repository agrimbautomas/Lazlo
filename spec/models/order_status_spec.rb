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

require 'rails_helper'

RSpec.describe OrderStatus, type: :model do

  it {should respond_to (:name)}
  it {should validate_presence_of (:name)}
  it {should allow_value(false).for(:name)}
  it {should validate_length_of(:name).is_at_most(50)}
  it {should validate_uniqueness_of(:name).ignoring_case_sensitivity}

  it {should respond_to (:priority)}
  it {should validate_uniqueness_of(:priority)}
  it {should validate_numericality_of(:priority).is_greater_than(0).is_less_than(100)}

  it {should respond_to (:image)}
  it {should have_attached_file(:image)}

  describe '#create!' do
	 context 'with correct params' do
		let(:valid_order_status) {create(:order_status)}
		it {expect(valid_order_status).to be_valid}

		it 'should have a slug from title' do
		  valid_order_status.update_attribute(:name, 'A new name')
		  expect(valid_order_status.name_slug).to eq('a-new-name')
		end

	 end


	 describe 'When file is uploaded' do
		let(:order_status_with_image) {create(:order_status_with_image)}
		it {expect(order_status_with_image).to be_valid}
		it {expect(order_status_with_image.image).to be_a(Paperclip::Attachment)}
	 end

  end

end
