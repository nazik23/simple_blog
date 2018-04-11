require 'rails_helper'

RSpec.describe Post, type: :model do
	it "body attribute shouldn't be empty" do
		post = build(:post, body: nil )
		expect(post).not_to be_valid
	end

	it "body attribute maximum length shouldn't be more than 1000" do
		post = build(:post, body: "Hello" * 201)
		expect(post).to be_invalid

		post.body = "Hello"
		expect(post).to be_valid
		expect(1..1000).to cover(post.body.length)
	end

	it "title attribute should be blank or in range (5..100)" do
		post = build(:post, title: nil)
		expect(post).to be_valid

		["Too", "too" * 50].each do |title|
			post.title = title
			expect(post).to be_invalid
			expect(5..100).not_to cover(post.title)
		end
	end
end
