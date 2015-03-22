class Game
  @players

  def initialize
    @players = []
  end

  def execute(command, callback)
    matchData = /^add player\s(\S+)/.match(command)
    player = matchData.captures.first
    @players << player
    playersTxt = @players.sort().join(', ')
    callback.call("Players: #{playersTxt}")
  end

end
