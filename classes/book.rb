require_relative 'item'

class Book < Item
  attr_accessor :id, :publisher, :cover_state, :title

  def initialize(title:, publisher:, cover_state:, publish_date:, id: SecureRandom.random_number(1..1000))
    super(id: id, publish_date: publish_date)
    @id = id
    @publisher = publisher
    @cover_state = cover_state
    @title = title
  end

  # If I need to print the book.
  def to_h
    {
      id: @id,
      publisher: @publisher,
      cover_state: @cover_state,
      title: @title,
      publish_date: @publish_date.strftime('%Y-%m-%d')
    }
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
