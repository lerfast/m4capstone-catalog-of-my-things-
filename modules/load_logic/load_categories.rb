module LoadCategories
  def self.load_authors(games, albums, books)
    authors = []
    File.open('data/authors.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        author = Author.new(data['first_name'], data['last_name'])

        game_items = games.select { |game| data['items'].include?('id' => game.id, 'class' => 'Game') }
        album_items = albums.select { |album| data['items'].include?('id' => album.id, 'class' => 'MusicAlbum') }
        book_items = books.select { |book| data['items'].include?('id' => book.id, 'class' => 'Book') }
        # Assign the corresponding arrays to the 'items' property of the Genre object
        author.items = game_items + album_items + book_items
        authors << author
      end
    end
    authors
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

  def self.load_labels(games, albums, books)
    labels = []
    File.open('data/labels.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        label = Label.new(title: data['title'], color: data['color'])

        game_items = games.select { |game| data['items'].include?('id' => game.id, 'class' => 'Game') }
        album_items = albums.select { |album| data['items'].include?('id' => album.id, 'class' => 'MusicAlbum') }
        book_items = books.select { |book| data['items'].include?('id' => book.id, 'class' => 'Book') }
        # Assign the corresponding arrays to the 'items' property of the Genre object
        label.items = game_items + album_items + book_items
        labels << label
      end
    end
    labels
  end
end
