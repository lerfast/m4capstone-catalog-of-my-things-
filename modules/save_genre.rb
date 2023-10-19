module SaveGenre
  def self.save_genre(genre)
    data = {
      name: genre.name
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
end