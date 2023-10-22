require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'

module Decorator
  def self.decorate(item, authors, genres, labels)
    puts 'first name of the author is:'
    author_first_name = gets.chomp
    puts 'last name of the author is:'
    author_last_name = gets.chomp

    if authors.any? { |author| author.first_name == author_first_name && author.last_name == author_last_name }
      item.author = authors.find { |author| author.first_name == author_first_name && author.last_name == author_last_name }
    else
      item.author = Author.new(author_first_name, author_last_name)
      authors << item.author
    end

    puts 'name of the genre is:'
    genre_name = gets.chomp

    if genres.any? { |genre| genre.name == genre_name }
      item.genre = genres.find { |genre| genre.name == genre_name }
    else
      item.genre = Genre.new(genre_name)
      genres << item.genre
    end

    puts 'title of the label is:'
    label_title = gets.chomp
    puts 'color of the label is:'
    label_color = gets.chomp

    if labels.any? { |label| label.title == label_title && label.color == label_color }
      item.label = labels.find { |label| label.title == label_title && label.color == label_color }
    else
      item.label = Label.new(title: label_title, color: label_color)
      labels << item.label
    end
  end
end
