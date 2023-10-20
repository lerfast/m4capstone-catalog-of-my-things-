module SaveBook
    def self.save_book(book)
      data = {
        publisher: book.publisher,
        cover_state: book.cover_state,
        publish_date: book.publish_date,
        id: book.id,
        archived: book.archived,
        author: author_to_h(book.author),
        genre: genre_to_h(book.genre),
        label: label_to_h(book.label)
      }
  
      File.open('data/books.json', 'a') do |file|
        file.puts(data.to_json)
      end
    end
  
    def self.load_books
      books = []
      File.open('data/books.json', 'r') do |file|
        file.each_line do |line|
          data = JSON.parse(line)
  
          author_data = data['author']
          author = Author.new(author_data['first_name'], author_data['last_name'])
  
          genre_data = data['genre']
          genre = Genre.new(genre_data['name'])
  
          label_data = data['label']
          label = Label.new(title: label_data['name'], color: label_data['color'])
          book = Book.new(data['publish_date'],
                                 cover_state: data['cover_state'],
                                 publisher: data['publisher'],
                                 id: data['id'],
                                 archived: data['archived'],
                                 author: author,
                                 genre: genre,
                                 label: label,
                                 )
          books << book
        end
      end
      books
    end
  
    def self.author_to_h(author)
      {
        first_name: author.first_name,
        last_name: author.last_name
      }
    end
  
    def self.genre_to_h(genre)
      {
        name: genre.name
      }
    end
  
    def self.label_to_h(label)
      {
        name: label.title,
        color: label.color
      }
    end
  end