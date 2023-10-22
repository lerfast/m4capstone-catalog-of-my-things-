module ListOptions
  def self.list_options(collection)
    puts "
█▀▄ █▀▀ █░░ █▀▀ ▀█▀ █▀▀   ▄▀█ █▄░█   █ ▀█▀ █▀▀ █▀▄▀█ ▀█
█▄▀ ██▄ █▄▄ ██▄ ░█░ ██▄   █▀█ █░▀█   █ ░█░ ██▄ █░▀░█ ░▄".blue
    loop do
      puts 'Select an item by index to delete or press 0 to go back.'
      number = gets.chomp.to_i
      if number.zero?
        return
      elsif number > collection.size
        puts 'Invalid index.'
      else
        collection.delete_at(number - 1)
        puts "
╔══╦╗─────────╔╗──╔╗───╔╗─────╔╗
╚╣╠╝╚╗────────║║──║║──╔╝╚╗────║║
─║╠╗╔╬══╦╗╔╗╔═╝╠══╣║╔═╩╗╔╬══╦═╝║
─║║║║║║═╣╚╝║║╔╗║║═╣║║║═╣║║║═╣╔╗║
╔╣╠╣╚╣║═╣║║║║╚╝║║═╣╚╣║═╣╚╣║═╣╚╝║
╚══╩═╩══╩╩╩╝╚══╩══╩═╩══╩═╩══╩══╝".blue
      end
    end
  end
end
