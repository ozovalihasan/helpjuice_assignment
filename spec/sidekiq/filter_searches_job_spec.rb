require 'rails_helper'

RSpec.describe FilterSearchesJob, type: :job do
  it "removes incomplete searches" do
    Search.create(keywords: "mo")
    Search.create(keywords: "mock")

    expect(Search.count).to be 2
    
    described_class.new.perform(Search.find_by(keywords: "mock").id)

    expect(Search.first.keywords).to eq "mock"
    expect(Search.count).to be 1
    
  end
end
