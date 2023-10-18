require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at, archived: false)
    unless valid_date_format?(last_played_at)
      raise ArgumentError,
            'Invalid last_played_date format. Please use YYYY-MM-DD.'
    end

    super(publish_date, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  rescue ArgumentError => e
    puts e.message
  end

  def can_be_archived?
    super && (Date.today.year - @last_played_at.year) > 2
  end
end
