require 'rspec'
require_relative '../classes/genre'

class Item
  attr_accessor :genre

  def initialize
    @genre = nil
  end
end

RSpec.describe Genre do
  let(:item) { Item.new('2019-01-01') }

  describe '#initialize' do
    it 'creates a new instance of Genre' do
      genre = Genre.new('Rock')
      expect(genre).to be_an_instance_of(Genre)
    end

    it 'sets the name attribute' do
      genre = Genre.new('Rock')
      expect(genre.name).to eq('Rock')
    end

    it 'sets the items attribute to an empty array' do
      genre = Genre.new('Rock')
      expect(genre.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      genre = Genre.new('Rock')
      genre.add_item(item)
      expect(genre.items).to include(item)
    end

    it 'sets the item genre to self' do
      genre = Genre.new('Rock')
      genre.add_item(item)
      expect(item.genre).to eq(genre)
    end
  end
end
