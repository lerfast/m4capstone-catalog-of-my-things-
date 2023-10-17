require_relative 'classes/game'
require 'json'

module Options
  def display_options
    loop do
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books.'
      puts '2 - List all music albums.'
      puts '3 - List all movies.'
      puts '4 - List of games.'
      puts '5 - List all genres.'
      puts '6 - List all labels.'
      puts '7 - List all authors.'
      puts '8 - List all sources.'
      puts '9 - Add a book.'
      puts '10 - Add a music album.'
      puts '11 - Add a movie.'
      puts '12 - Add a game.'
      puts '0 - Quit.'

      option = gets.chomp

      if number?(option)
        process_input(option.to_i)
      else
        show_error
      end
    end
  end

  def number?(obj)
    obj = obj.to_s unless obj.is_a? String
    /\A[+-]?\d+(\.\d+)?\z/.match(obj)
  end

  def process_input(option)
    case option
    # ... (otros casos)
    when 4
      list_games
    when 7
      list_authors
    when 12
      add_game
    when 0
      quit
    else
      show_error
    end
  end

  def list_games
    if @games.empty?
      puts 'No games available.'
    else
      @games.each_with_index do |game, index|
        puts "#{index + 1}.Date: #{game.publish_date} " \
             "Multiplayer: #{game.multiplayer} Last played at: #{game.last_played_at}"
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts 'No authors available.'
    else
      @authors.each_with_index do |author, index|
        puts "#{index + 1}. #{author.first_name} #{author.last_name}"
      end
    end
  end

  def add_game

    publish_date = ''
    loop do
      puts 'Enter the publish date of the game (YYYY-MM-DD):'
      publish_date = gets.chomp
      break if valid_date?(publish_date)

      puts 'Invalid date! Please enter a valid date in the format YYYY-MM-DD.'
    end

    puts 'Is the game multiplayer? (yes/no)'
    multiplayer = gets.chomp.downcase == 'yes'

    last_played_at = ''
    loop do
      puts 'Enter the last played date of the game (YYYY-MM-DD):'
      last_played_at = gets.chomp
      break if valid_date?(last_played_at)

      puts 'Invalid date! Please enter a valid date in the format YYYY-MM-DD.'
    end

    game = Game.new(publish_date, multiplayer, last_played_at)
    @games << game
    save_game_to_json(game)
    puts 'Game added successfully!'
  end

  # Añade este método de validación al módulo Options
  def valid_date?(date_str)
    Date.parse(date_str)
    true
  rescue ArgumentError
    false
  end

  def save_game_to_json(game)
    data = {
      publish_date: game.publish_date.to_s,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s,
      archived: game.archived
    }

    File.open('games.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def load_games_from_json
    games = []

    return games unless File.exist?('games.json')

    File.open('games.json', 'r').each do |line|
      data = JSON.parse(line)
      game = Game.new(data['publish_date'], data['multiplayer'], data['last_played_at'],
                      archived: data['archived'])
      games << game
    end

    games
  end

  def show_error
    puts 'Error! Please select a valid option.'
  end

  def quit
    puts 'Saving your data ...'
    exit
  end
end
