module Score

  def calculate(dice)
    return 0 if dice.empty?

    points = 0
    @scoring = 0
    @non_scoring_dice = dice.sort

    [1, 2, 3, 4, 5, 6].each do |n| # possible values
      total = @non_scoring_dice.count(n)
      next if total == 0

      if total >= 3
        points += n == 1 ? 1000 : 100 * n
        3.times { @non_scoring_dice.shift}
        @scoring += 3
      end

      total = @non_scoring_dice.count(n)
      if n == 5
        points += total * 50
      elsif n == 1
        points += total * 100
      end

      @scoring += total if n == 5 || n == 1
      @non_scoring_dice.delete(n)
    end

    @non_scoring = dice.count - @scoring
    points
  end

  def non_scoring
    @non_scoring
  end

end