require 'add_player_use_case'
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

      AddPlayerUseCase.new(@game_id,
                           'Pippo',
                           @game_persistence_gateway,
                           method(:update_players_names),
                           method(:update_failure_message))
                      .execute

      expect(@presentable_players).to eq ['Pippo']
      expect(@fail_message).to eq @initial_fail_message
    end
  end

  context 'when there is already a player' do
    it 'allows the user to add a second player' do
      @game_events.events << 'PLAYER_ADDED@_@Pippo'
      @game_persistence_gateway.setup_already_existing_game_events(@game_id, @game_events)

      AddPlayerUseCase.new(@game_id,
                           'Pluto',
                           @game_persistence_gateway,
                           method(:update_players_names),
                           method(:update_failure_message))
                      .execute

      expect(@presentable_players).to match_array ['Pippo', 'Pluto']
      expect(@fail_message).to eq @initial_fail_message
    end
  end
end
