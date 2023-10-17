require_relative 'item'

class Game < Item
    attr_accessor :multiplayer, :last_played_at
  
    def initialize(name, publish_date, multiplayer, last_played_at, archived: false)
      super(name, publish_date, archived: archived)
      
      unless valid_date_format?(last_played_at)
        raise ArgumentError, 'Invalid last_played_at format. Please use YYYY-MM-DD.'
      end
  
      @multiplayer = multiplayer
      @last_played_at = Date.parse(last_played_at)
    rescue ArgumentError => e
      puts e.message
    end
  
    def can_be_archived?
      super && (Date.today.year - @last_played_at.year) > 2
    end
  
    private
  
    def valid_date_format?(date)
      date.match?(/^\d{4}-\d{2}-\d{2}$/)
    end
  end
  
