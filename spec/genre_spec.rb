require 'rspec'
require_relative '../classes/genre'

RSpec.describe Genre do
  let(:genre) { Genre.new('Rock') }

  describe '#initialize' do
    it 'creates a new genre' do
      expect(genre).to be_an_instance_of(Genre)
    end
  end

  describe '#name' do
    it 'returns the name of the genre' do
      expect(genre.name).to eq('Rock')
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      expect(genre.add_item('item')).to eq(['item'])
    end
  end
end