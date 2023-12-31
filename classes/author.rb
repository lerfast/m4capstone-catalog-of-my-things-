require 'securerandom'

class Author
  attr_accessor :first_name, :last_name, :items

  def initialize(first_name, last_name, items: [])
    @id = SecureRandom.uuid
    @first_name = first_name
    @last_name = last_name
    @items = items
  end

  def add_item(item)
    @items << item
    item.author = self
  end

  def to_h
    {
      id: @id,
      first_name: @first_name,
      last_name: @last_name
    }
  end
end
