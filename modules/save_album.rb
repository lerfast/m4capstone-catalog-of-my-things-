module SaveAlbum
  def self.save_album(album)
    data = {
      publish_date: album.publish_date,
      id: album.id,
      archived: album.archived,
      author: author_to_h(album.author),
      genre: genre_to_h(album.genre),
      label: label_to_h(album.label),
      on_spotify: album.on_spotify
    }

    File.open('data/albums.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.load_albums
    albums = []
    File.open('data/albums.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)

        author_data = data['author']
        author = Author.new(author_data['first_name'], author_data['last_name'])

        genre_data = data['genre']
        genre = Genre.new(genre_data['name'])

        label_data = data['label']
        label = Label.new(title: label_data['name'], color: label_data['color'])
        album = MusicAlbum.new(data['publish_date'],
                               id: data['id'],
                               archived: data['archived'],
                               author: author,
                               genre: genre,
                               label: label,
                               on_spotify: data['on_spotify'])
        albums << album
      end
    end
    albums
  end

  def self.author_to_h(author)
    {
      first_name: author.first_name,
      last_name: author.last_name
    }
  end

  def self.genre_to_h(genre)
    {
      name: genre.name
    }
  end

  def self.label_to_h(label)
    {
      name: label.title,
      color: label.color
    }
  end
end
