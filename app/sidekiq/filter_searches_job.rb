class FilterSearchesJob
  include Sidekiq::Job

  def perform(search_id)
    reference_search = Search.find(search_id)
    return if reference_search.nil?

    searched_at = reference_search.created_at
    searches = Search.where(created_at: (searched_at - 60.seconds)..searched_at)
    keywords_with_searches = searches.group_by { |search| search.keywords.strip }

    delete_incomplete_searches(keywords_with_searches)
    delete_searches_having_same_keywords(keywords_with_searches)
  end

  def delete_incomplete_searches(keywords_with_searches)
    keywords_with_searches.each do |keywords, searches|
      next unless keywords_with_searches.keys.any?(/^#{keywords}.+/)

      searches.each(&:delete)
    end
  end

  def delete_searches_having_same_keywords(keywords_with_searches)
    keywords_with_searches.each do |_keywords, searches|
      searches.sort_by(&:created_at)[...-1].each(&:delete)
    end
  end
end
