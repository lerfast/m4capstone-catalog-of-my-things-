require_relative 'classes/game'
require_relative 'classes/music_album'
require_relative 'classes/book'
require_relative 'modules/decorator'
require_relative 'modules/list'
require 'json'

module Options
  include Decorator
  include List
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

  OPTION_ACTIONS = {
    1 => :list_books,
    2 => :list_albums,
    3 => :list_movies,
    4 => :list_games,
    5 => :list_genres,
    6 => :list_labels,
    7 => :list_authors,
    9 => :add_book,
    10 => :add_album,
    12 => :add_game,
    0 => :quit
  }.freeze

  def process_input(option)
    action = OPTION_ACTIONS[option]
    if action
      send(action)
    else
      show_error
    end
  end

  def list_albums
    if @albums.empty?
      puts 'No albums available.'
    else
      List.list_items(@albums)
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

  def list_genres
    List.list_genres(@genres)
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

  def list_labels
    if @labels.empty?
      puts 'No labels available.'
    else
      puts 'List of Labels:'
      @labels.each do |label|
        puts "ID: #{label.id}, Title: #{label.title}, Color: #{label.color}"
        puts 'Items:'
        if label.items.empty?
          puts 'No items associated with this label.'
        else
          label.items.each do |item|
            puts "- #{item.title}"
          end
        end
        puts '----------------------------------------------'
      end
    end
  end
  
  def add_album
    album_publish_date = verify_publish_date
    album = MusicAlbum.new(album_publish_date)
    Decorator.decorate(album, @authors, @genres, @labels)
    @albums << album
    puts '----------------------------------------------'
    puts 'Album added successfully!'
    puts '----------------------------------------------'
  end

  def add_book
    print 'Publisher: '
    publisher = gets.chomp
  
    while true
      print 'Cover state (select 1 for "good" or 2 for "bad" ): '
      cover_option = gets.chomp.to_i
  
      case cover_option
      when 1 then cover_state = 'good'
      when 2 then cover_state = 'bad'
      else
        puts "Wrong option \n\n"
        next
      end
      break
    end
  
    print 'Publish date (YYYY-MM-DD): '
    publish_date = gets.chomp
  
    book = Book.new(publisher: publisher, cover_state: cover_state, publish_date: publish_date)
    puts 'Book added successfully.'
    book
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
    date_str.match?(/^\d{4}-\d{2}-\d{2}$/)
  end

  def verify_publish_date
    publish_date = ''
    loop do
      puts 'Enter the publish date of the album (YYYY-MM-DD):'
      publish_date = gets.chomp
      break if valid_date?(publish_date)

      puts 'Invalid date! Please enter a valid date in the format YYYY-MM-DD.'
    end
    publish_date
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
