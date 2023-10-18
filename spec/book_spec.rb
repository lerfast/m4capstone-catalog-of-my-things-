require 'date'
require_relative '../classes/book'

describe Book do
  let(:publish_date) { Date.new(2023, 8, 1).strftime('%Y-%m-%d') } # Date to string

  it 'can be created' do
    book = Book.new(publisher: 'Gordona', cover_state: 'good', publish_date: publish_date)
    expect(book).to be_instance_of(Book)
  end

  it 'can be archived' do
    book = Book.new(publisher: 'Gordona', cover_state: 'bad', publish_date: publish_date)
    expect(book.send(:can_be_archived?)).to be_truthy
  end
end
