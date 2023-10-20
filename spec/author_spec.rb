require_relative '../classes/author'
describe Author do
  subject { Author.new('John', 'Doe') }
  describe 'when initialized' do
    it 'should have a first name' do
      expect(subject.first_name).to eq('John')
    end
    it 'should have a last name' do
      expect(subject.last_name).to eq('Doe')
    end
  end
  describe '#add_item' do
    let(:item) { double('Item') }
    before do
      allow(item).to receive(:author=)
    end
    it 'should add an item to items' do
      subject.add_item(item)
      expect(subject.items).to include(item)
    end
    it 'should set the author of the item' do
      subject.add_item(item)
      expect(item).to have_received(:author=).with(subject)
    end
  end
end