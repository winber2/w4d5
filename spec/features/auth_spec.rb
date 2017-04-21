require 'spec_helper'
require 'rails_helper'

feature "user features", type: :feature do

  feature "the signup process" do
    scenario "has a new user page" do
      sign_up_user("garbled_garbage", "suicide_squad")

      expect(page).to have_content("garbled_garbage")
      expect(current_path).to eq("/users/#{User.find_by(username: 'garbled_garbage').id}")
    end

    feature "signing up a user" do
      scenario "shows username on the homepage after signup" do
        sign_up_user("garbled_garbage", "suicide_squad")
        visit users_url

        expect(page).to have_content("garbled_garbage")
      end

      scenario "entering invalid parameters" do
        visit new_user_url
        fill_in "username", with: "error_prone_dufus"
        fill_in "password", with: ""
        click_on "Submit"

        expect(page).to have_content("INVALID")
        expect(current_path).to eq("/users/new")
      end
    end

  end

  feature "logging in" do

    scenario "shows username on the homepage after login" do
      User.create(username: "realtalk", password: "password")

      visit new_session_url
      fill_in "username", with: "realtalk"
      fill_in "password", with: "password"
      click_on "Submit"
    end

  end

  feature "logging out" do
    scenario "begins with a logged out state" do
      visit users_url


      expect(page).to have_content("Log in")
      expect(page).to have_content("Sign up")
    end

    scenario "doesn't show username on the homepage after logout" do
      sign_up_user("no_one_will_care", "goodbye")
      click_on "Log out"

      expect(page).to_not have_content("Log out")
    end
  end

end
