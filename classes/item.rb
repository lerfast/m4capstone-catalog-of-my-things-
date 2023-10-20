require 'securerandom'
require 'date'

class Item
  attr_reader :publish_date, :id, :archived, :label, :genre, :author

  def initialize(publish_date, id: SecureRandom.uuid, archived: false, author: nil, genre: nil, label: nil)
    @publish_date = publish_date
    @id = id
    @archived = archived
    @author = author
    @genre = genre
    @label = label
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def valid_date_format?(date)
    date.match?(/^\d{4}-\d{2}-\d{2}$/)
  end

  def can_be_archived?
    converted_date = Date.strptime(@publish_date, '%Y-%m-%d')
    (Date.today.year - converted_date.year) > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
