require 'securerandom'

class Item
  attr_reader :genre, :author, :source, :lablel, :publish_date

  def initialize(publish_date, archived: false)
    unless publish_date.match?(/^\d{4}-\d{2}-\d{2}$/)
      raise ArgumentError, 'Invalid publish_date format. Please use YYYY-MM-DD.'
    end

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
