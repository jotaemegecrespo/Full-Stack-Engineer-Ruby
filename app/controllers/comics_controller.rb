class ComicsController < ApplicationController
  def index
    @search = ComicsSearch.new(page: params[:page])
  end
end
