require './options'

class App
  include Options

  attr_accessor :games, :authors

  def initialize
    @albums = []
    @games = load_games_from_json
    @authors = []
  end

  def run
    display_options
  end
end
