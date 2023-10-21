require_relative 'classes/game'
require_relative 'classes/music_album'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/item'
require_relative 'modules/decorator'
require_relative 'modules/list'
require_relative 'modules/save_album'
require_relative 'modules/save_genre'
require_relative 'modules/save_label'
require_relative 'modules/save_book'
require_relative 'modules/save_game'
require_relative 'modules/save_author'
require 'colorize'
require 'json'

module Options
  include Decorator
  include List
  include SaveAlbum
  include SaveGame
  def display_options
    puts '
    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗
    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝
    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗    ██╗██╗██╗
     ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝    ╚═╝╚═╝╚═╝

    '.light_blue.underline
    loop do
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books.'
      puts '2 - List all music albums.'
      puts '3 - List of games.'
      puts '4 - List all genres.'
      puts '5 - List all labels.'
      puts '6 - List all authors.'
      puts '7 - Add a book.'
      puts '8 - Add a music album.'
      puts '9 - Add a game.'
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
    3 => :list_games,
    4 => :list_genres,
    5 => :list_labels,
    6 => :list_authors,
    7 => :add_book,
    8 => :add_album,
    9 => :add_game,
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

  def list_books
    if @books.empty?
      puts 'No books available.'
    else
      puts "
        __...--~~~~~-._   _.-~~~~~--...__
      //               `V'               \\\\
     //                 |                 \\\\
    //__...--~~~~~~-._  |  _.-~~~~~~--...__\\\\
   //__.....----~~~~._\\ | /_.~~~~----.....__\\\\
  ====================\\\\|//====================
                      `---`
      ".colorize(:light_blue )
      List.list_items(@books)
    end
  end

  def list_albums
    if @albums.empty?
      puts 'No albums available.'
    else
      puts "
___|\\_______|________|_______________________O__________@____________
___|/_______|________|_|___|__________|__@__|_____@__|_|____O._______||
__/|____4___|__O_____|_|___|__O.______|_|@__|____|___|_|___|O.______o||
_(_/^\\__4__@|_|_____@__|___|_|________|_|@__|____|___|_|___|________o||
__\\|/'_____@__|________|__@|_|________|_|________|___|_____|_________||
   d          |           @  |          |
      ".light_blue
      List.list_items(@albums)
    end
  end

  def list_games
    if @games.empty?
      puts 'No games available.'
    else
      puts "
__________________|      |____________________________________________
     ,--.    ,--.          ,--.   ,--.
    |oo  | _  \\  `.       | oo | |  oo|
o  o|~~  |(_) /   ;       | ~~ | |  ~~|o  o  o  o  o  o  o  o  o  o  o
    |/\\/\\|   '._,'        |/\\/\\| |/\\/\\|
__________________        ____________________________________________
                  |      |
                  ".colorize(:light_blue)
      List.list_items(@games)
    end
  end

  def list_genres
    List.list_genres(@genres)
  end

  def list_authors
    List.list_authors(@authors)
  end

  def list_labels
    List.list_labels(@labels)
  end

  def add_album
    album_publish_date = verify_publish_date
    album = MusicAlbum.new(album_publish_date)
    Decorator.decorate(album, @authors, @genres, @labels)
    @albums << album
    SaveAlbum.save_album(album)
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
    publish_date = verify_publish_date('Enter the publish date of the book (YYYY-MM-DD):')
    book = Book.new(publisher: publisher, cover_state: cover_state, publish_date: publish_date)
    Decorator.decorate(book, @authors, @genres, @labels)
    puts '----------------------------------------------'
    puts 'Book added successfully.'
    puts '----------------------------------------------'
    @books << book
    SaveBook.save_book(book)
  end

  def add_game
    game_publish_date = verify_publish_date
    puts 'Thats the game has multiplayer? (y/n)'
    game_multiplayer = gets.chomp
    game_last_played_date = verify_publish_date('Enter the last played date of the game (YYYY-MM-DD):')
    game = Game.new(game_publish_date, game_multiplayer, game_last_played_date)
    Decorator.decorate(game, @authors, @genres, @labels)
    @games << game
    SaveGame.save_game_to_json(game)
    puts '----------------------------------------------'
    puts 'Game added successfully!!!'
    puts '----------------------------------------------'
  end

  def valid_date?(date_str)
    date_str.match?(/^\d{4}-\d{2}-\d{2}$/)
  end

  def verify_publish_date(prompt = 'Enter the publish date of the item (YYYY-MM-DD):')
    publish_date = ''
    loop do
      puts prompt
      publish_date = gets.chomp
      break if valid_date?(publish_date)

      puts 'Invalid date! Please enter a valid date in the format YYYY-MM-DD.'
    end
    publish_date
  end

  def load_games_from_json
    SaveGame.load_games_from_json
  end

  def load_albums_from_json
    SaveAlbum.load_albums
  end

  def load_genres_from_json
    SaveGenre.load_genres
  end

  def load_labels_from_json
    SaveLabel.load_labels
  end

  def load_books_from_json
    SaveBook.load_books
  end

  def load_authors_from_json
    SaveAuthor.load_authors
  end

  def show_error
    puts 'Error! Please select a valid option.'
  end

  def quit
    puts 'Saving your data ...'
    exit
  end
end
