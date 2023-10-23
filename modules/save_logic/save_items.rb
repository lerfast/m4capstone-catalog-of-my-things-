module SaveItems
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

  def self.save_book(book)
    data = {
      publisher: book.publisher,
      cover_state: book.cover_state,
      publish_date: book.publish_date,
      id: book.id,
      archived: book.archived,
      author: book.author.to_h,
      genre: book.genre.to_h,
      label: book.label.to_h
    }

    File.open('data/books.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.save_game(game)
    data = {
      publish_date: game.publish_date,
      archived: game.archived,
      author: game.author.to_h,
      genre: game.genre.to_h,
      label: game.label.to_h,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s,
      id: game.id

    }

    File.open('data/games.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end
end
