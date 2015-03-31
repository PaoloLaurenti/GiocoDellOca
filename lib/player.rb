require 'presentable_player'

class Player
  @name

  def initialize(name)
    @name = name
  end

  def to_presentable
    presentable_player = PresentablePlayer.new
    presentable_player.name = @name
  end

  def has_name?(name)
    name == @name
  end
end
