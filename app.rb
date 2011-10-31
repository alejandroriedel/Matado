require 'rubygems' if RUBY_VERSION < '1.9'
require './lib/game'
require 'sinatra'

get '/' do
	@@matado = Matado.new
	if ((@randomWordToPlay = @@matado.getRandomWord) == "")
		@mainMessage = @@matado.status_message
		@disableButton = "disabled=true"
	end
	@setNameVisibility = "visibility:visible;display:inline;"
	@changeNameVisibility = "visibility:hidden;display:none;"
	erb :main
end

post '/' do
	@@matado.setPlayerName(params[:playerName]) if (params[:playerName]) != nil
	if ((@randomWordToPlay = @@matado.getRandomWord) == "")
		@mainMessage = @@matado.status_message
		@disableButton = "disabled=true"
	end
	if ((@playerName = @@matado.player_name) == "") or ((params[:changeName]) == "Y")
		@setNameVisibility = "visibility:visible;display:inline;"
		@changeNameVisibility = "visibility:hidden;display:none;"
	else
		@changeNameVisibility = "visibility:visible;display:inline;"
		@setNameVisibility = "visibility:hidden;display:none;"
	end
	erb :main
end

post '/config' do
	@@matado.addWord(params[:wordToAdd]) if (params[:wordToAdd]) != nil
	@@matado.deleteWord(params[:wordToDelete]) if (params[:wordToDelete]) != nil
	@@matado.saveWordsListToFile()if (params[:saveFile]) == "Y"
	if ((@randomWordToPlay = @@matado.getRandomWord) == "")
		@disableButton = "disabled=true"
		@hideWordsList = "visibility:hidden;display:none;"
		@WLMessage = "VACIA"
	else
		@WLMessage = ""
	end
	@WordsList = @@matado.words_list
	@configMessage = @@matado.status_message
	erb :config
end

post '/game' do
	@@matado.setSecret(params[:wordToPlay]) if (params[:wordToPlay]) != nil
	if (params[:letterAttempt]) != nil
		@@matado.tryWith(params[:letterAttempt])
		@gameMessage = @@matado.status_message
	end
	@@matado.guessWord(params[:wordAttempt]) if (params[:wordAttempt]) != nil
	@statusImage = @@matado.showImage()
	@playerName = @@matado.player_name
	@codedWord = @@matado.coded_word
	@errorsList = @@matado.errors_list
	@failedAttempts = @@matado.failed_attempts
	@searchUrl = @@matado.search_url
	@maxAttempts = @@matado.max_attempts	
	if @@matado.checkWinner
		@secretWord = @@matado.secret_word.to_s
		@resultMessage = @@matado.status_message
		@disableButton = "disabled=true" if ((@randomWordToPlay = @@matado.getRandomWord) == "")
		@@matado.reset()
		erb :result
	else
		if @@matado.checkLoser
			@resultMessage = @@matado.status_message
			@secretWord = @@matado.secret_word.to_s
			@@matado.reset()
			@disableButton = "disabled=true" if ((@randomWordToPlay = @@matado.getRandomWord) == "")
			erb :result
		else
			erb :game
		end
	end
end

post '/bye' do
	@playerName = @@matado.player_name
	erb :bye
end
