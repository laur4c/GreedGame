class DiceSet
  def roll(total)
    @values = total.times.map {rand(6) + 1}
  end

  def values
    @values
  end
end