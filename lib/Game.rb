class Game
  @response_callbacks

  def initialize
    @response_callbacks = []
  end

  def add_response_callback(callback)
    @response_callbacks << callback
  end

  def execute(command)
    @response_callbacks.each do |c|
      c.call('Players: Pippo')
    end
  end

end
