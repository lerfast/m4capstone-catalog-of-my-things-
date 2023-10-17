require 'securerandom'
require 'date'

class Item
  attr_accessor :name, :genre, :author, :source, :label
  attr_reader :publish_date, :id, :archived

  def initialize(name, publish_date, author = nil, archived: false)
    @name = name
    unless publish_date.match?(/^\d{4}-\d{2}-\d{2}$/)
      raise ArgumentError, 'Invalid publish_date format. Please use YYYY-MM-DD.'
    end

    @id = SecureRandom.uuid
    @publish_date = Date.parse(publish_date)
    @author = author  
    @archived = archived
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
