module SaveGame
  def self.save_game_to_json(game)
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

  def self.load_games_from_json
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
end
