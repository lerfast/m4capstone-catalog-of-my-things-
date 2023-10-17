require 'securerandom'

class Genre
  attr_reader :name

  def initialize(name)
    @id = SecureRandom.uuid
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
