module LoadItems
  def self.load_books
    books = []
    File.open('data/books.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)

        author_data = data['author']
        author = Author.new(author_data['first_name'], author_data['last_name'])

        genre_data = data['genre']
        genre = Genre.new(genre_data['name'])

        label_data = data['label']
        label = Label.new(title: label_data['name'], color: label_data['color'])

        book = Book.new(publisher: data['publisher'],
                        cover_state: data['cover_state'],
                        publish_date: data['publish_date'],
                        id: data['id'],
                        archived: data['archived'],
                        author: author,
                        genre: genre,
                        label: label)
        books << book
      end
    end
    books
  end

  def self.load_games
    games = []
    File.open('data/games.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)

        author_data = data['author']
        author = Author.new(author_data['first_name'], author_data['last_name'])

        genre_data = data['genre']
        genre = Genre.new(genre_data['name'])

        label_data = data['label']
        label = Label.new(title: label_data['name'], color: label_data['color'])
        game = Game.new(data['publish_date'],
                        data['multiplayer'],
                        data['last_played_at'],
                        archived: data['archived'],
                        author: author,
                        genre: genre,
                        label: label,
                        id: data['id'])
        games << game
      end
    end
    games
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