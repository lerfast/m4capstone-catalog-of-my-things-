require 'securerandom'

class Item
  attr_reader :genre, :author, :source, :lablel, :publish_date, :archived

  def initialize(publish_date, archived: false)
    @id = SecureRandom.uuid
    @publish_date = publish_date
    @archived = archived
  end

  def genre=(genre)
    @genre = genre
  end

  def author=(author)
    @author = author
  end

  def source=(source)
    @source = source
  end

  def lablel=(lablel)
    @lablel = lablel
  end
end

new_item = Item.new(1)
puts new_item.archived