require 'erb'
require 'json'

class Application
  def self.call(env)
    new(env).routes
  end
   
  def initialize(env)
    @request = Rack::Request.new(env)
    @class = ''
  end
   
  def routes
    case @request.path
    when "/" then to 'GameController#index'
    when "/settings" then to 'GameController#settings'
    when "/game" then to 'GameController#game'
    when "/guess" then to 'GameController#guess'
    when "/win" then to 'GameController#win'
    when "/lose" then to 'GameController#lose'
    when "/restart" then to 'GameController#restart'
    else Rack::Response.new("Not Found", 404)
    end
  end

  def to(str)
    controller = str.split('#')[0]
    method = str.split('#')[1]

    if @class.is_a? eval("#{controller}")
      @class.send("#{method}")
    else
      @class = eval("#{controller}.new(@request)")
      @class.send("#{method}")
    end
  end
end

require_relative 'context_helper'
require_relative '../controllers/base_controller'
require_relative '../controllers/game_controller'
