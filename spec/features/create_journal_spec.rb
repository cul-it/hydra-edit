# Generated via
#  `rails generate curation_concerns:work Journal`
require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a Journal' do
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
      visit new_curation_concerns_journal_path
      fill_in 'Title', with: 'Test Journal'
      click_button 'Create Journal'
      expect(page).to have_content 'Test Journal'
    end
  end
end
