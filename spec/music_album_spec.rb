require 'rspec'
require './classes/music_album'

RSpec.describe MusicAlbum do
  let(:album) { MusicAlbum.new('2019-01-01') }

  describe '#initialize' do
    it 'creates a new instance of MusicAlbum' do
      expect(album).to be_an_instance_of(MusicAlbum)
    end

    it 'inherits from Item' do
      expect(album).to be_a(Item)
    end

    it 'sets the on_spotify attribute to false by default' do
      expect(album.on_spotify).to eq(false)
    end
  end

  describe '#on_spotify' do
    it 'returns the on_spotify attribute' do
      expect(album.on_spotify).to eq(false)
    end

    it 'can be set to true' do
      album.on_spotify = true
      expect(album.on_spotify).to eq(true)
    end
  end

  describe '#genre=' do
    it 'sets the genre attribute' do
      genre = Genre.new('Rock')
      album.genre = genre
      expect(album.genre).to eq(genre)
    end

    it 'adds the album to the genre' do
      genre = Genre.new('Rock')
      album.genre = genre
      expect(genre.items).to include(album)
    end
  end
end
