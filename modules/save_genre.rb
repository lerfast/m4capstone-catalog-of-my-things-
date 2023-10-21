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

  def self.load_genres
    genres = []
    File.open('data/genres.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        genre = Genre.new(data['name'])
        genres << genre
      end
    end
    genres
  end

  def self.items_to_h(items)
    items.map do |item|
      {
        id: item.id,
        label: item.label.to_h,
        author: item.author.to_h,
      }
    end
  end
end
