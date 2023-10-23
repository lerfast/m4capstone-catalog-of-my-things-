require_relative 'save_items'
require_relative 'save_categories'

module SaveFiles
  include SaveItems
  include SaveCategories
  def self.erase_previous_data
    files_to_clear = ['data/albums.json', 'data/authors.json', 'data/labels.json', 'data/genres.json', 'data/books.json', 'data/games.json']

    begin
      files_to_clear.each do |file_path|
        File.open(file_path, 'w') do |file|
          file.truncate(0)
        end
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end

  def self.save_albums(albums)
    albums.each do |album|
      SaveItems.save_album(album)
    end
  end

  def self.save_books(books)
    books.each do |book|
      SaveItems.save_book(book)
    end
  end

  def self.save_games(games)
    games.each do |game|
      SaveItems.save_game(game)
    end
  end

  def self.save_authors(authors)
    authors.each do |author|
      SaveCategories.save_author(author)
    end
  end

  def self.save_labels(labels)
    labels.each do |label|
      SaveCategories.save_label(label)
    end
  end

  def self.save_genres(genres)
    genres.each do |genre|
      SaveCategories.save_genre(genre)
    end
  end
end
