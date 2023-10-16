require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label
  attr_reader :publish_date, :id, :archived

  def initialize(publish_date, archived: false)
    unless publish_date.match?(/^\d{4}-\d{2}-\d{2}$/)
      raise ArgumentError, 'Invalid publish_date format. Please use YYYY-MM-DD.'
    end

    @id = SecureRandom.uuid
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end
