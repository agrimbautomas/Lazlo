FactoryGirl.define do

  factory :user do

	 sequence(:name) {|n| "A User-name-#{n}"}
	 password "qwertyuio"
	 sequence(:email) {|n| "user#{n}@amalgama.co"}
	 confirmed_at Date.today - 2.days

	 factory :user_without_password do
		password nil
	 end

	 factory :user_without_email do
		email nil
	 end

	 factory :user_without_name do
		name nil
	 end

	 factory :user_not_confirmed do
		confirmed_at nil
	 end

	 factory :user_with_checkout_list do
		checkout_list
	 end

  end

end
