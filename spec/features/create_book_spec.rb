# Generated via
#  `rails generate curation_concerns:work Book`
require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a Book' do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
    end

    scenario do
      visit new_curation_concerns_book_path
      fill_in 'Title', with: 'Test Book'
      click_button 'Create Book'
      expect(page).to have_content 'Test Book'
    end
  end
end
