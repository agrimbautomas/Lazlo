# == Schema Information
#
# Table name: user_contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserContact, type: :model do

  it { should respond_to (:email) }

  it { should validate_presence_of(:email) }

end
