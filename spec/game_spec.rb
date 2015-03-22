require 'game'

describe Game, '"Gioco dell\'oca"' do
  context 'when there are no player' do
    it 'allows the user to add the first player' do
      response = ''
      game = Game.new
      game.execute 'add player Pippo', lambda { |r| response = r }
      expect(response).to eq 'Players: Pippo'
    end
  end

  context 'when there is already a player' do
    it 'allows the user to add a second player' do
      response = ''
      game = Game.new
      game.execute 'add player Pluto', lambda { |r| response = r }
      game.execute 'add player Pippo', lambda { |r| response = r }
      expect(response).to eq 'Players: Pippo, Pluto'
    end
  end
end
