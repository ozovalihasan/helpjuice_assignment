class Articles::KeywordsController < ApplicationController
  def index
    @searches = Search.order(created_at: :desc)
  end
end
