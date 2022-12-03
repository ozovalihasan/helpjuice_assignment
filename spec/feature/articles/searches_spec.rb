require 'rails_helper'

RSpec.describe 'relation', type: :feature do
  before :each do
    FactoryBot.rewind_sequences
    FactoryBot.create(:search)    
    FactoryBot.create_list(:article, 2)    
  end

  scenario 'A user can search for an article' do
    visit root_path
    
    fill_in('keywords', with: Search.first.keywords)

    expect(page).to have_content "Results for \"#{Search.first.keywords}\""
    expect(page).to have_content(Search.first.keywords, count: 3)
  end

  scenario 'A user can see all searches as a list' do
    FactoryBot.create(:search)    
    
    visit root_path
    
    find('a', text: "Keywords").click

    expect(page).to have_content Search.first.keywords
    expect(page).to have_content Search.second.keywords
  end
    
end
