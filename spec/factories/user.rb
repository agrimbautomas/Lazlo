FactoryGirl.define do

  factory :user do

	 sequence(:name) {|n| "A User-name-#{n}"}
	 password "qwertyuio"
	 sequence(:email) {|n| "user#{n}@amalgama.co"}

	 factory :user_without_password do
		password nil
	 end

	 factory :user_without_email do
		email nil
	 end

	 factory :user_without_name do
		name nil
	 end

  end

end
