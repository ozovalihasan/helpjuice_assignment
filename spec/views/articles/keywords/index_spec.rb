require 'rails_helper'

RSpec.describe "articles/keywords/index", type: :view do
  
  before(:each) {
    FactoryBot.rewind_sequences
    travel_to Time.zone.local(2020, 10, 1, 00, 00, 00) do
      FactoryBot.create_list(:mock_search, 2 )
    end
    
  }

  it "renders the view of Articles::KeywordsController#index correctly" do
    assign(:searches, Search.all)

    render
    expect(rendered).to have_css("turbo-frame#results")
    
    expect(rendered).to match( "keywords_1" )
    expect(rendered).to match( "keywords_2" )
      
    expect(rendered).to match_snapshot('index')
  end
end
