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
