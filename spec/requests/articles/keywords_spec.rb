require 'rails_helper'

RSpec.describe '/articles/keywords', type: :request do
  describe 'GET /articles/keywords' do
    let(:frame_id) { 'results' }

    before(:each) do
      FactoryBot.rewind_sequences
      FactoryBot.create_list(:mock_search, 2)
    end

    it 'redirects to the root page for the html format' do
      get articles_keywords_path

      expect(response).to have_http_status(:redirect)
    end

    it 'renders only a frame for a request for a turbo frame' do
      get articles_searches_path, headers: { 'Turbo-Frame' => 'results' }

      expect(response).to render_template(layout: false)
      expect(response).to have_http_status(:ok)

      expect(response.body).to have_css("turbo-frame##{frame_id}")
      expect(response.body).to match_snapshot('keywords/index/turbo_frame')
    end
  end
end
