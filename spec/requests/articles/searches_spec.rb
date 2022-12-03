require 'rails_helper'

RSpec.describe "/articles/search", type: :request do

  describe "GET /articles/search" do
    let(:frame_id) { "results" }

    before(:each) {
      FactoryBot.rewind_sequences
      FactoryBot.create_list(:mock_article, 2)
    }
    
    it "renders the view of Categories#show for the html format" do
      get articles_searches_path

      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    
      expect(response.body).to match_snapshot('articles/search/index/html')
    end

    it "renders only a frame for a request for a turbo frame" do

      get articles_searches_path, headers: { "Turbo-Frame" => "results" }

      expect(response).to render_template(layout: false)
      expect(response).to have_http_status(:ok)
      
      expect(response.body).to have_css("turbo-frame##{frame_id}")
      expect(response.body).to match_snapshot('articles/search/index/turbo_frame')
    end

  end
  
end
