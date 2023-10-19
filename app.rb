require './options'

class App
  include Options

  attr_accessor :games, :authors

  def initialize
    @albums = load_albums_from_json
    @books = load_books_from_json
    @genres = load_genres_from_json
    @labels = load_labels_from_json
    @games = load_games_from_json
    @authors = []
  end

  def run
    display_options
  end
end
