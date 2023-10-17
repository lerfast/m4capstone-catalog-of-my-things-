require './classes/item'

describe Item do
  subject { Item.new('2010-05-05') }

  describe '#can_be_archived?' do
    context 'when published more than 10 years ago' do
      it 'returns true' do
        expect(subject.can_be_archived?).to eq(true)
      end
    end

    context 'when published less than 10 years ago' do
      let(:recent_item) { Item.new('2020-05-05') }

      it 'returns false' do
        expect(recent_item.can_be_archived?).to eq(false)
      end
    end
  end
end
