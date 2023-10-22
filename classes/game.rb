require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :id

  def initialize(publish_date, multiplayer, last_played_at, archived: false, author: nil, genre: nil, label: nil, id: SecureRandom.uuid)
    super(publish_date, archived: archived, author: author, genre: genre, label: label, id: id)
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
