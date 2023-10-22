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

  def self.items_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
      }
    end
  end
end
