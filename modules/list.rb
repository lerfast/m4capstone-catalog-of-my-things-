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
        puts "#{index + 1}. #{genre.name}"
      end
    end
    puts '----------------------------------------------'
  end

  def self.list_labels(collection)
    puts '----------------------------------------------'
    if collection.empty?
      puts 'This list is empty'
    else
      collection.each do |label|
        puts "ID: #{label.id}, Title: #{label.title}, Color: #{label.color}"
        puts '----------------------------------------------'
      end
    end
  end

  def self.list_authors(collection)
    puts '----------------------------------------------'
    if collection.empty?
      puts 'This list is empty'
    else
      collection.each_with_index do |author, index|
        puts "#{index + 1}. #{author.first_name} #{author.last_name}"
      end
    end
    puts '----------------------------------------------'
  end
end
