module SaveLabel
  def self.save_labels(label)
    data = {
      title: label.title,
      color: label.color,
      items: items_to_h(label.items)
    }

    File.open('data/labels.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.load_labels(games, albums, books)
    labels = []
    File.open('data/labels.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        label = Label.new(title: data['title'], color: data['color'])

        game_items = games.select { |game| data['items'].include?('id' => game.id, 'class' => 'Game') }
        album_items = albums.select { |album| data['items'].include?('id' => album.id, 'class' => 'MusicalAlbum') }
        book_items = books.select { |book| data['items'].include?('id' => book.id, 'class' => 'Book') }
        # Assign the corresponding arrays to the 'items' property of the Genre object
        label.items = game_items + album_items + book_items
        labels << label
      end
    end
    labels
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
