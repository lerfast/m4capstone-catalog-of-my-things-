module List
  def self.list_items(collection)
    puts '----------------------------------------------'
    collection.each_with_index do |item, index|
      puts "#{index + 1}. Title: #{item.label.title} " \
           "Author: #{item.author.first_name} #{item.author.last_name} " \
           "Genre: #{item.genre.name} Publish date: #{item.publish_date}"
    end
    puts '----------------------------------------------'
  end

  def self.list_genres(collection)
    puts '----------------------------------------------'
    if collection.empty?
      puts 'This list is empty'
    else
      collection.each_with_index do |genre, index|
        puts "#{index + 1}. #{genre.name} (#{genre.items.count})"
      end
    end
    puts '----------------------------------------------'
  end

  def self.list_labels(collection)
    puts '----------------------------------------------'
    if collection.empty?
      puts 'This list is empty'
    else
      collection.each_with_index do |label, index|
        puts "#{index + 1}. Title: #{label.title}, Color: #{label.color} (#{label.items.count})"
      end
    end
    puts '----------------------------------------------'
  end

  def self.list_authors(collection)
    puts '----------------------------------------------'
    if collection.empty?
      puts 'This list is empty'
    else
      collection.each_with_index do |author, index|
        puts "#{index + 1}. #{author.first_name} #{author.last_name} (#{author.items.count})"
      end
    end
    puts '----------------------------------------------'
  end
end
