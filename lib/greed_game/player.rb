require 'logger'

class Player
  include Score
  attr_reader :score
  attr_reader :last_score

  def initialize
    @logger = ::Logger.new(STDOUT)
    @score = 0
    @last_score = 0
    @dice_set = DiceSet.new
  end

  def new_turn
    @last_score = 0
  end

  def reset_score
    @score = 0
  end

  def reaches_3000?
    @score >= 3000
  end

  def in_the_game?
    @score >= 300
  end

  def calculate_score(values)
    total = calculate(values)
    @last_score += total
    @score += total

    total
  end

  def has_non_scoring_dice?
    non_scoring > 0
  end

  def loose_accumulated_score_for_turn
    @score - @last_score
  end

  def count_non_scoring_dice
    non_scoring
  end

  def roll(dice)
    @dice_set.roll(dice)
    @logger.debug(@dice_set.values)
    @dice_set.values
  end
end