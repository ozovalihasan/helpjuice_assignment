class FilterSearchesJob
  include Sidekiq::Job

  def perform(search_id)
    searched_at = Search.find(search_id).created_at
    searches = Search.where(created_at: (searched_at - 5.seconds)..searched_at)
    all_keywords = searches.map(&:keywords) 

    searches.each do |search|
      search.delete if all_keywords.any?(/^#{search.keywords}.+/)
    end

  end
end
