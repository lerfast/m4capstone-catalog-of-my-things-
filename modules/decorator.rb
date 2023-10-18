require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/label'

module Decorator
  def self.decorate(item)
    item.author = Author.new('first', 'last')
    item.genre = Genre.new('genre')
    item.label = Label.new(title: 'label', color: 'color')
    item
    puts item.author.first_name
    puts item.genre.name
    puts item.label.title
  end
end