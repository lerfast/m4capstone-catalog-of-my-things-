require_relative 'classes/genre'
require_relative 'classes/game'
require_relative 'classes/author'

myGenre = Genre.new('Rock')
myGame = Game.new('2019-01-01', 'yes', '2019-01-01')
myAuthor = Author.new('Carlos', 'Chancleto')
myGame.genre = myGenre
myGame.author = myAuthor
puts myGame.author.items