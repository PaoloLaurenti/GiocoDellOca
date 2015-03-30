require 'player'

class Game
  @players_changed_listeners
  @players

  def self.create_by(game_events)
    Game.new(game_events)
  end

  def add_players_changed_listener(callback_listener)
    @players_changed_listeners << callback_listener
  end

  def add_player(player_name)
    @players << Player.new(player_name)
    notify_players_has_changed()
  end

  def do_with_events(something_to_do)
    something_to_do.call(@events)
  end

  private

  def initialize(game_events)
    @players_changed_listeners = []
    @players = []
    load_current_game_state_by(game_events)
  end

  def notify_players_has_changed
    @players_changed_listeners.each do |p|
      p.call(@players.map {|p| p.to_presentable() })
    end
  end

  def load_current_game_state_by(game_events)
    game_events.events.each do |ge|
      event_tokens = ge.split('@_@')

      if event_tokens.first == 'PLAYER_ADDED'
        player_name = event_tokens[1]
        @players << Player.new(player_name)
      end
    end
  end
end
