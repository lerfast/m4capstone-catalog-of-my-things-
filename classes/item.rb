require 'securerandom'
require 'date'

class Item
  attr_accessor :name, :genre, :author, :source, :label
  attr_reader :publish_date, :id, :archived

  def initialize(name, publish_date, author = nil, archived: false)
    @name = name

    raise ArgumentError, 'Invalid publish_date format. Please use YYYY-MM-DD.' unless valid_date_format?(publish_date)

    @id = SecureRandom.uuid
    @publish_date = Date.parse(publish_date)
    @author = author
    @archived = archived
  rescue ArgumentError => e
    puts e.message
  end

  # Este método verifica si el formato de la fecha es válido
  def valid_date_format?(date)
    date.match?(/^\d{4}-\d{2}-\d{2}$/)
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
