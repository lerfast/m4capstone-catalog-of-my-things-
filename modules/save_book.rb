module SaveBook
  def self.save_book(book)
    data = {
      publisher: book.publisher,
      cover_state: book.cover_state,
      publish_date: book.publish_date,
      id: book.id,
      archived: book.archived,
      author: book.author.to_h,
      genre: book.genre.to_h,
      label: book.label.to_h
    }

    File.open('data/books.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end
end
