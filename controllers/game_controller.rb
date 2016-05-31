require 'codebreaker'

class GameController < BaseController

  @@game = Codebreaker::Game.new

  def initialize req
    @request = req
  end

  def index
    @@settings = {}
    @@curr_results = []
    view("index", {scores:scores})
  end

  def game
    return redirect_to('/') if @@settings.empty?
    view("game", {
      curr_results:@@curr_results,
      scores:scores,
      hint:@@settings[:hint],
      mode:@@settings[:mode],
      attempt:(@@settings[:mode].to_i - @@settings[:attempt].to_i).to_s
    })
  end

  def scores
    @@game.show_score[:scores].sort_by { |v| v[:score] }.reverse
  end

  def guess
    @@settings[:attempt] += 1
    try = @request.params["attempt"]
    attempt = {guess:try, result:@@game.attempt(try)}
    @@curr_results << attempt
    case 
    when attempt[:result] == :win
      @@settings[:state] = "win"
      redirect_to('/win')
    when attempt[:result] == :lose
      @@settings[:state] = "lose"
      redirect_to('/lose')
    else
      redirect_to('/game')
    end
    
  end

  def settings
    params = @request.params
    if params['state'] == 'newgame'
      @@game.start 
      @@game.mode = params["mode"].to_sym if params.has_key?("mode")

      @@settings = {
        hint: if params.has_key?("hint") then @@game.hint else '-' end, 
        state: "current_game", 
        user: params['user'], 
        mode: @@game.instance_variable_get(:@mode).to_s, 
        attempt: 0
      }
    end
    p @@settings
    redirect_to('/game')
  end

  def win
    return redirect_to('/') unless @@settings[:state] == "win"
    @@settings[:state] = "end"
    @@game.save_score(@@settings[:user])
    view("win", scores:scores,)
  end

  def lose
    return redirect_to('/') unless @@settings[:state] == "lose"
    view("lose")
  end

  def restart
    @@game.play_again
    @@settings = {}
    @@curr_results = []
    redirect_to('/')
  end
  
end