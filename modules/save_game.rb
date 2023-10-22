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
end
