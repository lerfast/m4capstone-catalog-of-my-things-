require './classes/game'

describe Game do
  subject { Game.new('A Sample Game', '2010-05-05', true, '2018-01-01') }

  describe '#can_be_archived?' do
    context 'when both parent and last_played_at conditions are true' do
      it 'returns true' do
        expect(subject.can_be_archived?).to eq(true)
      end
    end

    context 'when only parent condition is true' do
      let(:game) { Game.new('Another Sample Game', '2020-05-05', true, '2018-01-01') }

      it 'returns false' do
        expect(game.can_be_archived?).to eq(false)
      end
    end

    context 'when only last_played_at condition is true' do
      let(:game) { Game.new('Yet Another Sample Game', '2010-05-05', true, '2021-05-05') }

      it 'returns false' do
        expect(game.can_be_archived?).to eq(false)
      end
    end
  end
end
