require_relative 'save_genre'
require_relative 'save_label'
require_relative 'save_author'

module SaveManager
  include SaveGenre
  include SaveLabel
  include SaveAuthor
  def self.save_item(genre, label, author)
    SaveAuthor.save_author(author)
    SaveGenre.save_genre(genre)
    SaveLabel.save_labels(label)
  end
end
    