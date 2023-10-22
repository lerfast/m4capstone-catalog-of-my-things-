module SaveAuthor
  def self.save_author(author)
    data = {
      first_name: author.first_name,
      last_name: author.last_name,
      items: items_to_h(author.items)
    }

    File.open('data/authors.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.load_authors(games, albums, books)
    authors = []
    File.open('data/authors.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        author = Author.new(data['first_name'], data['last_name'])

        game_items = games.select { |game| data['items'].include?('id' => game.id, 'class' => 'Game') }
        album_items = albums.select { |album| data['items'].include?('id' => album.id, 'class' => 'MusicalAlbum') }
        book_items = books.select { |book| data['items'].include?('id' => book.id, 'class' => 'Book') }
        # Assign the corresponding arrays to the 'items' property of the Genre object
        author.items = game_items + album_items + book_items
        authors << author
      end
    end
    authors
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
