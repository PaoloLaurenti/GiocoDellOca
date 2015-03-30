class GamePersistenceGatewayTestDouble
  @store

  def initialize
    @store = {}
  end

  def get_game_events_by(game_id)
    @store[game_id]
  end

  def save(game_id, game_events)
  end

  def setup_already_existing_game_events(game_id, game_events)
    @store[game_id] = game_events
  end
end
