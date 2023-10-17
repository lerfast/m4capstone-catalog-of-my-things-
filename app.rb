require './options'

class App
  include Options
  
  attr_accessor :games, :authors

  def initialize
    @games = load_games_from_json
    @authors = []  # Puedes agregar una lógica similar para autores más tarde si es necesario
  end

  def run
    display_options
  end
end

