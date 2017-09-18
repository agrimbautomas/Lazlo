# == Schema Information
#
# Table name: product_rows
#
#  id               :integer          not null, primary key
#  quantity         :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer
#  products_list_id :integer
#

require 'rails_helper'

RSpec.describe ProductRow, type: :model do

  it { should respond_to (:product) }
  it { should belong_to (:product) }
  it { should validate_presence_of (:product) }

  it { should respond_to (:quantity) }
  it { should validate_presence_of (:quantity) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe '#create!' do
    let(:valid_product_row) { create(:product_row) }

    context 'with correct params' do
      it { expect(valid_product_row).to be_valid }
    end

  end

end
