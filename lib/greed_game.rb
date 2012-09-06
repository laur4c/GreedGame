require 'logger'
require 'greed_game/dice_set.rb'
require 'greed_game/score.rb'
require 'greed_game/player.rb'

class GreedGame
  EXIT_KEY = 0

  def initialize
    @players = []
    @logger = ::Logger.new(STDOUT)
  end

  def start
    puts "Welcome to Greed Game! Enjoy it :)"

    ask_for_players
    launch
  end

  def ask_for_players
    puts "How many players?"
    n = gets
    n = n.to_i

    if ! (n > 1)
      puts "Greed is a dice game played among 2 or more players"
      ask_for_players
    end
    n.to_i.times { @players << Player.new}
  end

  def finish_turn?(n_player)
    n_player == @players.size
  end

  def finish_game?
    ret = false
    @players.each do |player|
      ret = player.reaches_3000?
    end
    ret
  end

  def play(player, dice = 5)
    total = player.calculate_score(player.roll(dice))
    @logger.debug(total)
    puts "Total: #{total}"

    if total == 0
      player.loose_accumulated_score_for_turn
      puts "You loose #{player.last_score} points. Total #{player.score}"
    elsif player.has_non_scoring_dice?
      puts "Accumulated points: #{player.score}"
      puts "Accumulated points in turn: #{player.last_score}"

      puts "Do you want to roll again using only the non-scoring dice? (Y/N)"
      option = gets
      play(player, player.count_non_scoring_dice) if option.chop! == "Y"
    end
  end

  def launch
    n = 0
    values = []
    loop do
      player = @players[n]
      puts "Please, Player #{n}: press 1 to roll, 0 to quit"
      input = gets

      break if input.to_i == EXIT_KEY

      player.new_turn
      play(player)

      if !player.in_the_game?
          player.reset_score
      end

      break if finish_game?

      n = n.next
      (n = 0) if finish_turn?(n)
    end
    play_last_turn if finish_game?
    good_bye
  end

  def show_winner
    max = 0
    @players.each do |player|
      if player.score > max
        max = player.score
        winner = player.index
      end
    end

    puts "And the winner is....... the #{winner} player!!"
  end

  def play_last_turn
    i = 1
    @players.each do |player|
      puts "Player #{i} rolling..."
      play(player)
    end

    show_winner
  end

  def good_bye
    puts "Bye!"
  end
end