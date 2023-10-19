require './options'

class App
  include Options

  attr_accessor :games, :authors

  def initialize
    @albums = load_albums_from_json
    @books = []
    @genres = load_genres_from_json
    @labels = []
    @games = load_games_from_json
    @authors = []
  end

  def run
    display_options
  end
end
