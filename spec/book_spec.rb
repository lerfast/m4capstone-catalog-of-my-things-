require 'date'
require_relative '../classes/book'

describe Book do
  let(:publish_date) { Date.new(2023, 8, 1) }
  let(:book_data) do
    {
      id: 123,
      publisher: 'Publisher',
      cover_state: 'Good',
      title: 'Title',
      publish_date: publish_date
    }
  end

  it 'can be created' do
    book = Book.new(**book_data)
    expect(book).to be_instance_of(Book)
  end

  it 'can be converted to hash' do
    book = Book.new(**book_data)
    book_hash = book.to_h
    expect(book_hash).to eq(book_data.merge(publish_date: publish_date.strftime('%Y-%m-%d')))
  end
end
