require_relative 'classes/game'
require_relative 'classes/music_album'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/item'
require_relative 'modules/decorator'
require_relative 'modules/list'
require_relative 'modules/load_logic/load_items'
require_relative 'modules/load_logic/load_categories'
require_relative 'modules/save_logic/save_files'
require_relative 'modules/list_options'
require 'colorize'
require 'json'

module Options
  include Decorator
  include List
  include LoadItems
  include LoadCategories
  include SaveFiles
  include ListOptions
  def display_options
    puts '
██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗    ██╗██╗██╗
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝    ╚═╝╚═╝╚═╝
 '.light_blue
    loop do
      puts 'Please choose an option by entering a number:'
      puts '1 - List all books.'.light_green
      puts '2 - List all music albums.'.light_cyan
      puts '3 - List of games.'.light_yellow
      puts '4 - List all genres.'.light_magenta
      puts '5 - List all labels.'.cyan
      puts '6 - List all authors.'.red
      puts '7 - Add a book.'.light_green
      puts '8 - Add a music album.'.light_cyan
      puts '9 - Add a game.'.light_yellow
      puts '0 - Quit.'.light_blue
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
      ".colorize(color: :light_green, mode: :bold)
      List.list_items(@books)
      ListOptions.list_options(@books)
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
      ".colorize(color: :light_cyan, mode: :bold)
      List.list_items(@albums)
      ListOptions.list_options(@albums)
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
                  ".colorize(color: :light_yellow, mode: :bold)
      List.list_items(@games)
      ListOptions.list_options(@games)
    end
  end

  def list_genres
    puts "
█▀▀ █▀▀ █▄░█ █▀█ █▀▀ █▀
█▄█ ██▄ █░▀█ █▀▄ ██▄ ▄█".light_magenta
    List.list_genres(@genres)
  end

  def list_labels
    puts "
█░░ ▄▀█ █▄▄ █▀▀ █░░ █▀
█▄▄ █▀█ █▄█ ██▄ █▄▄ ▄█".cyan
    List.list_labels(@labels)
  end

  def list_authors
    puts "
▄▀█ █░█ ▀█▀ █░█ █▀█ █▀█ █▀
█▀█ █▄█ ░█░ █▀█ █▄█ █▀▄ ▄█".red
    List.list_authors(@authors)
  end

  def add_book
    puts "

█▀▀ █▀█ █▀▀ ▄▀█ ▀█▀ █▀▀   ▄▀█   █▄▄ █▀█ █▀█ █▄▀
█▄▄ █▀▄ ██▄ █▀█ ░█░ ██▄   █▀█   █▄█ █▄█ █▄█ █░█".light_green
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
    @books << book
    puts "

╔══╗──────╔╗───────╔╗─╔╗────╔╗
║╔╗║──────║║───────║║─║║────║║
║╚╝╚╦══╦══╣║╔╗╔══╦═╝╠═╝╠══╦═╝║
║╔═╗║╔╗║╔╗║╚╝╝║╔╗║╔╗║╔╗║║═╣╔╗║
║╚═╝║╚╝║╚╝║╔╗╗║╔╗║╚╝║╚╝║║═╣╚╝║
╚═══╩══╩══╩╝╚╝╚╝╚╩══╩══╩══╩══╝".colorize(color: :light_green, mode: :bold)
  end

  def add_album
    puts "
█▀▀ █▀█ █▀▀ ▄▀█ ▀█▀ █▀▀   ▄▀█ █▄░█   ▄▀█ █░░ █▄▄ █░█ █▀▄▀█
█▄▄ █▀▄ ██▄ █▀█ ░█░ ██▄   █▀█ █░▀█   █▀█ █▄▄ █▄█ █▄█ █░▀░█".light_cyan
    album_publish_date = verify_publish_date
    album = MusicAlbum.new(album_publish_date)
    Decorator.decorate(album, @authors, @genres, @labels)
    @albums << album
    puts "
╔═══╦╗╔╗─────────────╔╗─╔╗────╔╗
║╔═╗║║║║─────────────║║─║║────║║
║║─║║║║╚═╦╗╔╦╗╔╗╔══╦═╝╠═╝╠══╦═╝║
║╚═╝║║║╔╗║║║║╚╝║║╔╗║╔╗║╔╗║║═╣╔╗║
║╔═╗║╚╣╚╝║╚╝║║║║║╔╗║╚╝║╚╝║║═╣╚╝║
╚╝─╚╩═╩══╩══╩╩╩╝╚╝╚╩══╩══╩══╩══╝".colorize(color: :light_cyan, mode: :bold)
  end

  def add_game
    puts "

█▀▀ █▀█ █▀▀ ▄▀█ ▀█▀ █▀▀   ▄▀█   █▀▀ ▄▀█ █▀▄▀█ █▀▀
█▄▄ █▀▄ ██▄ █▀█ ░█░ ██▄   █▀█   █▄█ █▀█ █░▀░█ ██▄".light_yellow
    game_publish_date = verify_publish_date
    puts 'Thats the game has multiplayer? (y/n)'
    game_multiplayer = gets.chomp
    game_last_played_date = verify_publish_date('Enter the last played date of the game (YYYY-MM-DD):')
    game = Game.new(game_publish_date, game_multiplayer, game_last_played_date)
    Decorator.decorate(game, @authors, @genres, @labels)
    @games << game
    puts "
╔═══╗──────────────╔╗─╔╗────╔╗
║╔═╗║──────────────║║─║║────║║
║║─╚╬══╦╗╔╦══╗╔══╦═╝╠═╝╠══╦═╝║
║║╔═╣╔╗║╚╝║║═╣║╔╗║╔╗║╔╗║║═╣╔╗║
║╚╩═║╔╗║║║║║═╣║╔╗║╚╝║╚╝║║═╣╚╝║
╚═══╩╝╚╩╩╩╩══╝╚╝╚╩══╩══╩══╩══╝".colorize(color: :light_yellow, mode: :bold)
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

  def load_genres_from_json
    LoadCategories.load_genres(@games, @albums, @books)
  end

  def load_labels_from_json
    LoadCategories.load_labels(@games, @albums, @books)
  end

  def load_authors_from_json
    LoadCategories.load_authors(@games, @albums, @books)
  end

  def load_books_from_json
    LoadItems.load_books
  end

  def load_albums_from_json
    LoadItems.load_albums
  end

  def load_games_from_json
    LoadItems.load_games
  end

  def show_error
    puts 'Error! Please select a valid option.'
  end

  def quit
    SaveFiles.erase_previous_data
    SaveFiles.save_books(@books)
    SaveFiles.save_albums(@albums)
    SaveFiles.save_games(@games)
    SaveFiles.save_authors(@authors)
    SaveFiles.save_genres(@genres)
    SaveFiles.save_labels(@labels)
    puts 'Data saved.'
    puts "

░██████╗░░█████╗░░█████╗░██████╗░██████╗░██╗░░░██╗███████╗██╗
██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗░██╔╝██╔════╝██║
██║░░██╗░██║░░██║██║░░██║██║░░██║██████╦╝░╚████╔╝░█████╗░░██║
██║░░╚██╗██║░░██║██║░░██║██║░░██║██╔══██╗░░╚██╔╝░░██╔══╝░░╚═╝
╚██████╔╝╚█████╔╝╚█████╔╝██████╔╝██████╦╝░░░██║░░░███████╗██╗
░╚═════╝░░╚════╝░░╚════╝░╚═════╝░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝".colorize(color: :light_blue, mode: :bold)
    exit
  end
end
