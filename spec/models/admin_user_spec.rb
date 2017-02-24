require 'rails_helper'

RSpec.describe AdminUser, type: :model do

  it { should respond_to (:email) }
  it { should respond_to (:password) }
  it { should respond_to (:has_role?) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

end
