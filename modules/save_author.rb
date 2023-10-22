module SaveAuthor
  def self.save_author(author)
    data = {
      first_name: author.first_name,
      last_name: author.last_name,
      items: items_to_h(author.items)
    }

    File.open('data/authors.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.items_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
    }
    end
  end
end
