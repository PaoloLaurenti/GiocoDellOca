require 'game'

describe Game, '"Gioco dell\'oca"' do
  context 'when there are no player' do
    it 'allows the user to add the first player' do
      response = ''
      game = Game.new
      game.add_response_callback(lambda { |r| response = r })
      game.execute 'add player Pippo'
      expect(response).to eq 'Players: Pippo'
    end
  end
end
