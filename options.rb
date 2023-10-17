require_relative './classes/game'

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
      puts "No games available."
    else
      @games.each_with_index do |game, index|
        puts "#{index + 1}.Name: #{game.name} Date: #{game.publish_date} Multiplayer: #{game.multiplayer} Last played at: #{game.last_played_at}"
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts "No authors available."
    else
      @authors.each_with_index do |author, index|
        puts "#{index + 1}. #{author.first_name} #{author.last_name}"
      end
    end
  end

  def add_game
    puts "Enter the name of the game:"
    name = gets.chomp

    puts "Enter the publish date of the game (YYYY-MM-DD):"
    publish_date = gets.chomp

    puts "Is the game multiplayer? (yes/no)"
    multiplayer = gets.chomp.downcase == 'yes' ? true : false

    puts "Enter the last played date of the game (YYYY-MM-DD):"
    last_played_at = gets.chomp

    # Crear una nueva instancia de Game y agregarla a la lista @games.
    game = Game.new(name, publish_date, multiplayer, last_played_at)
    @games << game

    puts "Game added successfully!"
  end

  def show_error
    puts 'Error! Please select a valid option.'
  end

  def quit
    puts 'Saving your data ...'
    exit
  end
end
