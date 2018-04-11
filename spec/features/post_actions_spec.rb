require 'rails_helper'

feature "PostActions" do
	feature "before user log in" do
		scenario "should get index" do
			visit '/'
			expect(page).to have_content('Posts')
		end

		it "should redirect to log in page if try to create new post" do
			visit '/'
			click_on('New Post')
			expect(page).to have_content('Log in')
			expect(page).to have_selector('input')
		end
	end
	feature "log in" do

	  scenario "as existing user" do
		  visit 'login'
		  fill_in('Email', with: 'bob.biba25@i.ua')
		  fill_in('Password', with: 'secret')
		  click_button('Log in')
		  expect(page).to have_content 'Signed in successfully'
		  expect(page).to have_content 'Logout'
	  end
	end
	feature "after user log in" do
          background do
		  visit 'login'
		  fill_in('Email', with: 'bob.biba25@i.ua')
		  fill_in('Password', with: 'secret')
		  click_button('Log in')
		  @post = build(:post)
          end

	  scenario "can create post" do
		  visit '/'
		  click_link('New Post')
		  expect(page).to have_content('Title Body Tags')
		  fill_in('Title', with: @post.title)
		  fill_in('Body', with: @post.body)
		  click_button 'Add Post'
		  expect(page).to have_content "#{@post.title} #{@post.body}"
	  end

	  scenario "should show post" do
		  visit 'posts/2'
		  expect(page).to have_content 'Edit | Back'
	  end

	  scenario "should get edit" do
		  visit 'posts/2/edit'
		  expect(page).to have_content 'Editing Post'
	  end

          scenario "should update post" do
		  visit 'posts/2/edit'
		  fill_in('Title', with: 'Updated Title')
		  click_button 'Add Post'
		  expect(page).to have_content 'Updated Title'
	  end

	  scenario "should destroy post", js: true do
		  visit '/'
		  page.accept_confirm do
			  click_on 'Delete'
		  end
		  expect(page).to have_content 'Post was successfully destroyed'
	  end

	end
end
