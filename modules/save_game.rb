module SaveGame
    def self.save_game_to_json(game)
      data = {
        publish_date: game.publish_date,
        archived: game.archived,
        author: author_to_h(game.author),
        genre: genre_to_h(game.genre),
        label: label_to_h(game.label),
        multiplayer: game.multiplayer,
        last_played_at: game.last_played_at.to_s
       
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
                                 label: label
                                 )
          games << game
        end
      end
      games
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
  