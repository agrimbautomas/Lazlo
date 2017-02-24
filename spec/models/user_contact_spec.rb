require 'rails_helper'

RSpec.describe UserContact, type: :model do

  it { should respond_to (:email) }

  it { should validate_presence_of(:email) }

end
