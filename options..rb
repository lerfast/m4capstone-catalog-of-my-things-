module Options
  def display_options
    loop do
      puts 'Please choose an option by entering a number:
 
        1 - List all books.
        2 - List all music albums.
        3 - List all movies.
        4 - List of games
        5 - List all genre
        6 - List all labels
        7 - List all authors
        8 - List all sources
        9 - Add a book
        10 - Add a music album
        11 - Add a movie
        12 - Add a game.
        0  - Quit'
  
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
  
    when 1
      puts "OPtion 1 has been selected\n"
    when 2
      puts "OPtion 2 has been selected\n"
    # Add more options here
    when 0
      quit
    else
      show_error
    end
  end
  
  def show_error
    puts 'Error! Please select a valid option.'
  end
  
  def quit
    puts 'saving your data ...'
    exit
  end
end
