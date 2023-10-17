require 'securerandom'
require './classes/item'

class MusicAlbum < Item
  attr_accessor :genre, :author, :source, :label
  attr_reader :publish_date

  def initialize(publish_date, archived: false, on_spotify: false)
    super(publish_date, archived: archived)
    @on_spotify = on_spotify
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
