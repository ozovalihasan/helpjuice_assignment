class Articles::SearchesController < ApplicationController
  def index
    @articles = Article.all
  end

  private
  
  def search_params
    params.require(:search).permit(:keywords)
  end
end
