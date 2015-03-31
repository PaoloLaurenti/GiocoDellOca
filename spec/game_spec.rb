require 'use_case/add_player_use_case'
require 'game_persistence_gateway_test_double'
require 'game_events'

describe AddPlayerUseCase, '"Gioco dell\'oca"' do
  def update_players_names(players)
    @presentable_players += players
  end

  def update_failure_message(message)
    @fail_message = message
  end

  def get_random_text()
    (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def add_game_player(player_name)
    AddPlayerUseCase.new(@game_id,
    player_name,
    @game_persistence_gateway,
    method(:update_players_names),
    method(:update_failure_message))
    .execute
  end

  before :each do
    @presentable_players = []
    @initial_fail_message = get_random_text()
    @fail_message = @initial_fail_message
    @game_id = SecureRandom.uuid
    @game_persistence_gateway = GamePersistenceGatewayTestDouble.new
    @game_events = GameEvents.new
  end

  context 'when there are no player' do
    it 'allows the user to add the first player' do
      @game_persistence_gateway.setup_already_existing_game_events(@game_id, @game_events)

      add_game_player('Pippo')

      expect(@presentable_players).to eq ['Pippo']
      expect(@fail_message).to eq @initial_fail_message
    end
  end

  context 'when there is already a player' do
    it 'allows the user to add a second player' do
      @game_events.events << 'PLAYER_ADDED@_@Pluto'
      @game_persistence_gateway.setup_already_existing_game_events(@game_id, @game_events)

      add_game_player('Pippo')

      expect(@presentable_players).to match_array ['Pippo', 'Pluto']
      expect(@fail_message).to eq @initial_fail_message
    end

    context 'when the user tries to add a player with the same name of the first one' do
      it 'notifies that the player already exists' do
        @game_events.events << 'PLAYER_ADDED@_@Pippo'
        @game_persistence_gateway.setup_already_existing_game_events(@game_id, @game_events)

        add_game_player('Pippo')

        expect(@presentable_players).to eq []
        expect(@fail_message).to eq "Player 'Pippo' already exists"
      end
    end
  end
end
