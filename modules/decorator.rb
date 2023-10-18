require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'

module Decorator
  def self.decorate(item)

    puts 'first name of the author is:'
    author_first_name = gets.chomp
    puts 'last name of the author is:'
    author_last_name = gets.chomp
    item.author = Author.new(author_first_name, author_last_name)

    puts 'name of the genre is:'
    genre_name = gets.chomp
    item.genre = Genre.new(genre_name)

    puts 'title of the label is:'
    label_title = gets.chomp
    puts 'color of the label is:'
    label_color = gets.chomp
    item.label = Label.new(title: label_title, color: label_color)
  end
end