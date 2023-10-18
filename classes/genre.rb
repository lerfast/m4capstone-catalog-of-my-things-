require 'securerandom'

class Genre
  attr_reader :name, :items

  def initialize(name)
    @id = SecureRandom.uuid
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self unless item.genre == self
  end
end
