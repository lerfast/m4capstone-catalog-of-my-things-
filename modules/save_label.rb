module SaveLabel
  def self.save_labels(label)
    data = {
      title: label.title,
      color: label.color,
      items: items_to_h(label.items)
    }

    File.open('data/labels.json', 'a') do |file|
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
