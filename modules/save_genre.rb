module SaveGenre
  def self.save_genre(genre)
    data = {
      name: genre.name,
      items: items_to_h(genre.items)
    }

    File.open('data/genres.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.load_genres(games, albums, books)
    genres = []
    File.open('data/genres.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        genre = Genre.new(data['name'])
        game_items = games.select { |game| data['items'].include?('id' => game.id, 'class' => 'Game') }
        album_items = albums.select { |album| data['items'].include?('id' => album.id, 'class' => 'MusicAlbum') }
        book_items = books.select { |book| data['items'].include?('id' => book.id, 'class' => 'Book') }
  
        # Assign the corresponding arrays to the 'items' property of the Genre object
        genre.items = game_items + album_items + book_items
        genres << genre
      end
    end
    genres
  end

  def self.items_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
      }
    end
  end
end
