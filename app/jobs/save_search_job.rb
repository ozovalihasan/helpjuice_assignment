class SaveSearchJob < ApplicationJob
  queue_as :default

  def perform(searched_at)
    searches = Search.where(created_at: (searched_at - 5.seconds)..searched_at)
    all_keywords = searches.map(&:keywords) 

    searches.each do |search|
      search.delete if all_keywords.any?(/^#{search.keywords}.+/)
    end

  end
end
