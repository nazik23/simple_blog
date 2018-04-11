require 'test_helper'

class PostTest < ActiveSupport::TestCase
	test "post body attribute shouldn't be empty" do
		post = Post.new
		assert post.invalid?
		assert post.errors[:body].any?
	end

	test "post body attribute maximum length 1000" do
		post = Post.new(body: "Hello" * 201)
		assert post.invalid?
		assert post.errors[:body].any?

		post = Post.new(body: "Hello")
		assert post.valid?
		assert_not post.errors[:body].any?
	end

	test "post title attribute should be blank or in range 5-100" do
		post = Post.new(body: "Hello")
		assert post.valid?
		assert_not post.errors[:title].any?	

                ["Too", "Too" * 50].each do |title|
		post.update(title: title)
		assert post.invalid?
		assert post.errors[:title].any?
		end
	end
end
