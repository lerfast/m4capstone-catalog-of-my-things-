require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(name, publish_date, multiplayer, last_played_at, archived: false)
    super(name, publish_date, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  def can_be_archived?
    super && (Date.today.year - @last_played_at.year) > 2
  end
end
