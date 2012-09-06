Gem::Specification.new do |s|
  s.name        = 'greed_game'
  s.version     = '0.0.0'
  s.date        = '2012-09-04'
  s.summary     = "Greed Dice Game"
  s.description = "Greed dice game exercise from Ruby Koans"
  s.authors     = ["Laura Corvalán"]
  s.email       = 'corvalan.laura@gmail.com'
  s.files       = [
    "lib/greed_game.rb",
    "lib/greed_game/dice_set.rb",
    "lib/greed_game/player.rb",
    "lib/greed_game/score.rb"
  ]
  s.extra_rdoc_files = ['doc/GREED_RULES.txt']
  s.add_runtime_dependency 'logger'
end
