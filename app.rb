require './options'

class App
  include Options
  
  attr_accessor :games, :authors

  def initialize
    @games = []
    @authors = []
  end

  def run
    display_options
  end
end
