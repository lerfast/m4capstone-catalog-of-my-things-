require 'securerandom'
require_relative 'item'

class Book < Item
  attr_accessor :id, :publisher, :cover_state, :author, :genre, :label

  def initialize(publisher:, cover_state:, publish_date:, id: SecureRandom.uuid, archived: false, author: nil, genre: nil,
                 label: nil)
    super(publish_date, archived: archived, author: author, genre: genre, label: label)
    @id = id
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
