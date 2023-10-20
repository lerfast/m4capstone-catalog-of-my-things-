module SaveAuthor
  def self.save_author(author)
    data = {
      first_name: author.first_name,
      last_name: author.last_name
    }

    File.open('data/authors.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.load_authors
    authors = []
    File.open('data/authors.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        author = Author.new(data['first_name'], data['last_name'])
        authors << author
      end
    end
    authors
  end
end
