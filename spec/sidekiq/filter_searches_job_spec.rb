require 'rails_helper'

RSpec.describe FilterSearchesJob, type: :job do
  it 'removes incomplete searches' do
    Search.create(keywords: ' mock ')
    Search.create(keywords: 'mock mock2')
    Search.create(keywords: 'mock mock2 ')

    expect(Search.count).to be(3)

    described_class.new.perform(Search.find_by(keywords: 'mock mock2 ').id)

    expect(Search.count).to be 1
    expect(Search.first.keywords).to eq 'mock mock2 '
  end
end
