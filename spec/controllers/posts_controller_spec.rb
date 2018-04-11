require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	describe "before user log in" do
		it "should get index" do
			get :index
			expect(response).to have_http_status(:success)
		end

		it "should get new" do
			get :new
			expect(response).to have_http_status(:redirect)
		end
	end
	describe "after user log in" do
	  before(:all) {
		  @user = build(:user)
		#  @post = create(:post)
	  }
	  let(:post_new) { create(:post)}

	  it "should get new" do
		  @request.env["devise.mapping"] = Devise.mappings[:user]
		  sign_in @user
		  get :new
		  expect(response).to have_http_status(:success)
	  end

	  it "should create post" do
		  @request.env["devise.mapping"] = Devise.mappings[:user]
		  sign_in @user
		  expect{post_new}.to change{Post.count}.by(1)
	  	  expect(post_new).to be_a(Post)
	  end

	  it "should show post" do
		  @request.env["devise.mapping"] = Devise.mappings[:user]
		  sign_in @user
		  post_new
		  get :show, params[:id]= post_new.id
		  expect(response).to have_http_status(:success)
	  end

	 # it "should get edit" do

	end
end
