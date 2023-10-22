module SaveAlbum
  def self.save_album(album)
    data = {
      publish_date: album.publish_date,
      id: album.id,
      archived: album.archived,
      author: album.author.to_h,
      genre: album.genre.to_h,
      label: album.label.to_h,
      on_spotify: album.on_spotify,
      class: album.class.to_s
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
end
