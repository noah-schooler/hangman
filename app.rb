require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/hangman')
require('./lib/words')

get('/') do
  @hangman = Hangman.new()
  @letter = "start"
  erb(:hangman)
end

post('/') do
  @letter = params['letter']
  @hangman = Hangman.current_game
  erb(:hangman)
end

# post('/lose') do
#   @letter = "lose"
#   @hangman = Hangman.current_game
#   erb(:hangman)
# end
#
# post('/win') do
#   @letter = "win"
#   @hangman = Hangman.current_game
#   erb(:hangman)
# end
