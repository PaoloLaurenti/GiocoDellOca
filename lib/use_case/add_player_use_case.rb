require 'game'

class AddPlayerUseCase
  @game_id
  @player_name
  @game_persistence_gateway
  @on_success
  @on_failure

  def initialize(game_id, player_name, game_persistence_gateway, on_success, on_failure)
    @game_id = game_id
    @player_name = player_name
    @game_persistence_gateway = game_persistence_gateway
    @on_success = on_success
    @on_failure = on_failure
  end

  def execute
    game_events = @game_persistence_gateway.get_game_events_by(@game_id)
    game = Game.create_by(game_events)
    game.add_players_changed_listener(@on_success)
    
    game.add_player(@player_name)
  end
end
