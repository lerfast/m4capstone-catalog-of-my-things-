require 'securerandom'

class Genre
  attr_reader :name, :items

  def initialize(name, items: [])
    @id = SecureRandom.uuid
    @name = name
    @items = items
  end

  def add_item(item)
    @items << item
    item.genre = self unless item.genre == self
  end

  def to_h
    {
      id: @id,
      name: @name
    }
  end
end
