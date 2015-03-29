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
    players_names =  @players.map { |p| p.name }
    @players_changed_listeners.each do |p|
      p.call(players_names)
    end
  end

  def do_with_events(something_to_do)
    something_to_do.call(@events)
  end

  private

  def initialize(game_events)
    @players_changed_listeners = []

    @players = []
    game_events.events.each do |ge|
      if ge.start_with?('PLAYER_ADDED')
        player_name = ge.split('@_@')[1]
        @players << Player.new(player_name)
      end
    end
  end
end
