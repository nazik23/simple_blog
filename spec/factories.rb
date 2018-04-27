FactoryBot.define do
  factory :comment do
    post nil
    body "MyText"
    user nil
  end

	factory :user do
		id 25
		initialize_with { User.find_or_create_by(id: id)}

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
