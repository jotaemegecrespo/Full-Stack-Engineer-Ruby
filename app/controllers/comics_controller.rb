class ComicsController < ApplicationController
  def index
    if @character = params[:character]
      @characters = Marvel::CharacterSearch.new(character: params[:character]).characters
      render and return unless @characters.present?
    end
    @search = Marvel::ComicsSearch.new(page: params[:page], characters: @characters&.map(&:id))

  end

  def fav
    @comic = params[:id]
    add_favourite @comic
    head :ok
  end

  private

  def add_favourite comic
    session[:favourites] ||= {}
    session[:favourites][comic] ^= true
  end
end
