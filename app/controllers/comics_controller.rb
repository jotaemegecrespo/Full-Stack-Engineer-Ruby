class ComicsController < ApplicationController
  def index
    if @character = params[:character]
      @characters = Marvel::CharacterSearch.new(character: params[:character]).characters
    end

    @search = Marvel::ComicsSearch.new(page: params[:page], characters: @characters&.map(&:id))
  end
end
