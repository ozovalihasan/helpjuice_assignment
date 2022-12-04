require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'scopes' do
    describe '.search' do
      it 'returns articles having keywords in their body' do
        FactoryBot.create(:mock_article, body: 'mock body')
        expect(Article.search('mock').size).to eql 1
      end
    end
  end
end
