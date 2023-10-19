module SaveLabel
    def self.save_labels(label)
      data = {
        title: label.title,
        color: label.color
      }
  
      File.open('data/labels.json', 'a') do |file|
        file.puts(data.to_json)
      end
    end
  
    def self.load_labels
      label = []
      File.open('data/labels.json', 'r') do |file|
        file.each_line do |line|
          data = JSON.parse(line)
          label = Label.new(data['title'], data['color'])
          labels << label
        end
      end
      labels
    end
  end