require_relative 'classes/genre'
require_relative 'classes/game'

myGenre = Genre.new('Rock')
myGame = Game.new('2019-01-01', 'yes', '2019-01-01')
puts myGame.multiplayer