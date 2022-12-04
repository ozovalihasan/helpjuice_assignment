class Articles::KeywordsController < ApplicationController
  def index
    redirect_to root_path unless turbo_frame_request?
    @searches = Search.order(created_at: :desc)
  end
end
