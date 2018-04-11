FactoryBot.define do
	factory :user do
		id 25
		initialize_with { User.find_or_create_by(id: id)}
	#	sequence(:id, 5) { |n| n * 5 }
	#	first_name "Bob"
	#	last_name "Biba"
	#	email { "#{first_name}.#{last_name}#{id}@i.ua".downcase }
	#	password 'secret'
	#	password_confirmation 'secret'


		factory :user_with_posts do
			transient do
				posts_count 5
			end

			after(:create) do |user, evaluator|
				create_list(:post, evaluator.count_posts, user: user)
			end
		end
	end

	factory :post do
		title "Title"
		body "Body!Body!"
		user
	end
end
