require 'rails_helper'

RSpec.describe 'articles/searches/index', type: :view do
  before(:each) do
    FactoryBot.rewind_sequences
    FactoryBot.create_list(:mock_article, 2)
  end

  context 'if there are article to show' do
    it 'renders the view of Articles::SearchesController#index correctly' do
      assign(:articles, Article.all)

      render
      expect(rendered).to have_css('turbo-frame#results')
      expect(rendered).to match('body_1 keywords_1')
      expect(rendered).to match('body_2 keywords_2')
      expect(rendered).to match('title_1')
      expect(rendered).to match('title_2')

      expect(rendered).to match_snapshot('index/with_articles')
    end
  end

  context 'if there is no any article to show' do
    it 'renders the view of Articles::SearchesController#index correctly' do
      assign(:articles, [])

      render
      expect(rendered).to have_css('turbo-frame#results')

      expect(rendered).to match_snapshot('index/no_article')
    end
  end

  context 'if there is valid keywords ' do
    it 'renders the view of Articles::SearchesController#index correctly' do
      assign(:keywords, 'mock_keywords')
      assign(:articles, [])

      render
      expect(rendered).to have_css('turbo-frame#results')
      expect(rendered).to match('mock_keywords')

      expect(rendered).to match_snapshot('index/with_keywords')
    end
  end

  context 'if there are no valid keywords ' do
    it 'renders the view of Articles::SearchesController#index correctly' do
      assign(:keywords, '')
      assign(:articles, [])

      render
      expect(rendered).to have_css('turbo-frame#results')
      expect(rendered).to match('Last articles')

      expect(rendered).to match_snapshot('index/no_keywords')
    end
  end
end
