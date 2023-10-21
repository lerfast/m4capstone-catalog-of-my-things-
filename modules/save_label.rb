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

  def self.load_labels
    labels = []
    File.open('data/labels.json', 'r') do |file|
      file.each_line do |line|
        data = JSON.parse(line)
        label = Label.new(title: data['title'], color: data['color'], items: data['items'])
        labels << label
      end
    end
    labels
  end

  def self.items_to_h(items)
    items.map do |item|
      {
        id: item.id,
        class: item.class.to_s,
        title: item.label.title
      }
    end
  end
end
