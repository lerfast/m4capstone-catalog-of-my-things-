require 'securerandom'
require_relative 'item'

class MusicAlbum < Item
  attr_accessor :author, :source, :label, :on_spotify
  attr_reader :publish_date

  def initialize(publish_date, id: SecureRandom.uuid, archived: false, author: nil, genre: nil, label: nil, on_spotify: false)
    super(publish_date, id: id, archived: archived, author: author, genre: genre, label: label)
    @on_spotify = on_spotify
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
