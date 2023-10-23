module SaveCategories
  def self.save_label(label)
    data = {
      title: label.title,
      color: label.color,
      items: labels_to_h(label.items)
    }

    File.open('data/labels.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.labels_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
      }
    end
  end

  def self.save_genre(genre)
    data = {
      name: genre.name,
      items: genres_to_h(genre.items)
    }

    File.open('data/genres.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.genres_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
      }
    end
  end

  def self.save_author(author)
    data = {
      first_name: author.first_name,
      last_name: author.last_name,
      items: authors_to_h(author.items)
    }

    File.open('data/authors.json', 'a') do |file|
      file.puts(data.to_json)
    end
  end

  def self.authors_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s
      }
    end
  end
end
