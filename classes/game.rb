require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at, archived: false)
    loop do
      break if valid_date_format?(last_played_at)

      puts 'Invalid last_played_date format. Please use YYYY-MM-DD.'
      last_played_at = gets.chomp
    end

    super(publish_date, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  def valid_date_format?(str)
    !Date.parse(str).nil?
  rescue StandardError
    false
  end

  def can_be_archived?
    super && (Date.today.year - @last_played_at.year) > 2
  end
end
