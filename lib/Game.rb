class Game
  @response_callbacks
  @players

  def initialize
    @response_callbacks = []
    @players = []
  end

  def add_response_callback(callback)
    @response_callbacks << callback
  end

  def execute(command)
    matchData = /^add player\s(\S+)/.match(command)
    player = matchData.captures.first
    @players << player
    @response_callbacks.each do |c|
      playersTxt = @players.sort().join(', ')
      c.call("Players: #{playersTxt}")
    end
  end

end
