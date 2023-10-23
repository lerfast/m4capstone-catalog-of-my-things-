require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'

module Decorator
  def self.decorate(item, authors, genres, labels)
    author_first_name, author_last_name = author_info
    item.author = find_or_create_author(authors, author_first_name, author_last_name)

    genre_name = genre_info
    item.genre = find_or_create_genre(genres, genre_name)

    label_title, label_color = label_info
    item.label = find_or_create_label(labels, label_title, label_color)
  end

  def self.author_info
    puts 'first name of the author is:'
    author_first_name = gets.chomp
    puts 'last name of the author is:'
    author_last_name = gets.chomp
    [author_first_name, author_last_name]
  end

  def self.find_or_create_author(authors, first_name, last_name)
    author = authors.find { |a| a.first_name == first_name && a.last_name == last_name }
    return author if author

    new_author = Author.new(first_name, last_name)
    authors << new_author
    new_author
  end

  def self.genre_info
    puts 'name of the genre is:'
    gets.chomp
  end

  def self.find_or_create_genre(genres, genre_name)
    genre = genres.find { |g| g.name == genre_name }
    return genre if genre

    new_genre = Genre.new(genre_name)
    genres << new_genre
    new_genre
  end

  def self.label_info
    puts 'title of the label is:'
    label_title = gets.chomp
    puts 'color of the label is:'
    label_color = gets.chomp
    [label_title, label_color]
  end

  def self.find_or_create_label(labels, title, color)
    label = labels.find { |l| l.title == title && l.color == color }
    return label if label

    new_label = Label.new(title: title, color: color)
    labels << new_label
    new_label
  end
end
