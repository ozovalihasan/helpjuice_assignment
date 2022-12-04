class Articles::SearchesController < ApplicationController
  def index
    @keywords = search_params[:keywords]

    if @keywords.present?
      @search = Search.create(search_params)
      FilterSearchesJob.perform_async(@search.id)
      @articles = Article.search(@keywords)
    else
      @articles = Article.limit(5).order(created_at: :desc)
    end
  end

  private

  def search_params
    params.permit(:keywords)
  end
end
