require 'securerandom'

class Item
  attr_accessor :genre, :author, :source, :lablel
  attr_reader :publish_date

  def initialize(publish_date, archived: false)
    unless publish_date.match?(/^\d{4}-\d{2}-\d{2}$/)
      raise ArgumentError, 'Invalid publish_date format. Please use YYYY-MM-DD.'
    end

    @id = SecureRandom.uuid
    @publish_date = publish_date
    @archived = archived
  end
end
