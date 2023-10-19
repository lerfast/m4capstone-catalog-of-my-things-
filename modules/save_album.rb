module SaveAlbum
  def self.save_album(album)
    data = {
      publish_date: album.publish_date,
      id: album.id,
      archived: album.archived,
      author: album.author,
      genre: album.genre,
      label: album.label,
      on_spotify: album.on_spotify
    }

    File.open('albums.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end
end
