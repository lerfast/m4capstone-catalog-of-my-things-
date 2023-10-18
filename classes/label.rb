class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title:, color:, id: SecureRandom.random_number(1..1000), items: [])
    @id = id
    @title = title
    @color = color
    @items = items
  end

  def add_item(item)
    @items.push(item)
    item.label = self
  end

  def to_h
    {
      id: @id,
      title: @title,
      color: @color,
      items: @items.map(&:to_h)
    }
  end
end
