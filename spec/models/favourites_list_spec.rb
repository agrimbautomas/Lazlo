# == Schema Information
#
# Table name: favourites_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FavouritesList, type: :model do


  let (:john) { User.create! email: 'john1988@theamalgama.com', password: 'asd789de', password_confirmation: 'asd789de' }

  let(:current_user) { User.first }
  let(:category1) { Category.create!(name: 'Mesas Ratonas') }
  let(:a_product) { Product.new(name: 'Another fake Product', price: 5000, category: category1,
                                description: 'Some random description') }

  context 'on model validations' do
    it { should respond_to(:user) }
    it { should respond_to(:product_rows) }

    it { should belong_to (:user) }
    it { should have_many(:product_rows) }
  end

  describe 'when is created' do
    it 'should have validations params' do
      favourites_list = FavouritesList.create(:user => current_user)
      expect(favourites_list).to be_valid
    end

  end
end
