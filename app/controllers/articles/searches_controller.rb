class Articles::SearchesController < ApplicationController
  def index
    if search_params[:keywords].present?
      @search = Search.create(search_params)
      SaveSearchJob.perform_later(@search.created_at)
      @articles = Article.search(@search[:keywords])
    else
      @articles = Article.limit(5).order("RANDOM()")
    end
  end

  private
  
  def search_params
    params.permit(:keywords)
  end
end
