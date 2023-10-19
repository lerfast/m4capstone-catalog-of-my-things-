require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'
require_relative 'save_genre'
require_relative 'save_label'

module Decorator
  include SaveGenre
  include SaveLabel
  def self.decorate(item, authors, genres, labels)
    puts 'first name of the author is:'
    author_first_name = gets.chomp
    puts 'last name of the author is:'
    author_last_name = gets.chomp
    item.author = Author.new(author_first_name, author_last_name)
    authors << item.author

    puts 'name of the genre is:'
    genre_name = gets.chomp
    item.genre = Genre.new(genre_name)
    genres << item.genre
    SaveGenre.save_genre(item.genre)

    puts 'title of the label is:'
    label_title = gets.chomp
    puts 'color of the label is:'
    label_color = gets.chomp
    item.label = Label.new(title: label_title, color: label_color)
    labels << item.label
    SaveLabel.save_labels(item.label)
  end
end
