module List
  def self.list_items(collection)
    collection.each_with_index do |item, index|
      puts "#{index + 1}. Title: #{item.label.title} " \
           "Author: #{item.author.first_name} #{item.author.last_name} " \
           "Genre: #{item.genre.name} Publish date: #{item.publish_date}"
    end
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
end
