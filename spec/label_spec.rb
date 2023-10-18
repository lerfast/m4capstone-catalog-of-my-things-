require_relative '../classes/label'

describe Label do
  let(:label) { Label.new(title: 'Science', color: 'color') }

  it 'can be created' do
    expect(label).to be_instance_of(Label)
  end

  it 'can add an item' do
    book = Book.new(publisher: 'Gordona', cover_state: 'bad', publish_date: '2023-08-01')
    label.add_item(book)
    expect(label.items).to include(book)
  end
end
