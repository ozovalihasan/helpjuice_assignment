class FilterSearchesJob
  include Sidekiq::Job

  def perform(search_id)
    reference_search = Search.find(search_id)
    return if reference_search.nil?
    
    searched_at = reference_search.created_at
    searches = Search.where(created_at: (searched_at - 60.seconds)..searched_at)
    keywords_with_searches = searches.group_by {|search| search.keywords.strip }

    keywords_with_searches.each do |keywords, searches|
      if keywords_with_searches.keys.any?(/^#{keywords}.+/)
        searches.each do |unnecessary_search|
          unnecessary_search.delete
        end
      end
    end

    keywords_with_searches.each do |keywords, searches|
      searches.sort_by(&:created_at)[...-1].each do |unnecessary_search|
        unnecessary_search.delete
      end
    end
    
  end
end
