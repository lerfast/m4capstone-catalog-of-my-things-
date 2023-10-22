module SaveAlbum
  def self.save_album(album)
    data = {
      publish_date: album.publish_date,
      id: album.id,
      archived: album.archived,
      author: album.author.to_h,
      genre: album.genre.to_h,
      label: album.label.to_h,
      on_spotify: album.on_spotify
    }

    File.open('data/albums.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end
end
