# == Schema Information
#
# Table name: user_contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  message    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UserContact, type: :model do

  it { should respond_to (:email) }

  it { should validate_presence_of(:email) }

end
