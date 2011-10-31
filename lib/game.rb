class Matado
	attr_accessor :words_list,:secret_word,:coded_word,:errors_list,:failed_attempts,:status_message,:letters_list,:search_url,:max_attempts,:player_name

	def initialize
		Array @words_list = []
		Array @errors_list = []
		Array @letters_list = []
		Array @coded_word = []
		Array @secret_word = []
		@words_list_file = ""
		@game_log_file = ""
		@player_name = ""
		setWordsListFilePath("./public")
		setLogFilePath("./public")
		loadWordsListFromFile()
		reset()
	end

	def reset()
		@secret_word.clear
		@coded_word.clear
		@errors_list.clear
		@letters_list.clear
		@failed_attempts = "0"
		@status_message = ""
		@search_url = ""
		@max_attempts = "1"
		@guess_word = "N"
	end

	def addWord(word)
		word = word.upcase
		unless @words_list.include?(word)
			@words_list.push(word)
			@words_list = @words_list.sort
			@status_message = "PALABRA AGREGADA CORRECTAMENTE"
		else
			@status_message = "LA PALABRA YA EXISTE EN LA LISTA"
		end
	end

	def deleteWord(word)
		word = word.upcase
		if @words_list.include?(word)
			@words_list.delete(word)
			@status_message = "PALABRA BORRADA CORRECTAMENTE"
		else
			@status_message = "LA PALABRA NO SE ENCUENTRA EN LA LISTA"
		end
	end

	def setSecret(word)
		@secret_word = word.upcase.split("")
		@coded_word.replace(@secret_word)
		for index in (1..@coded_word.count-2) do
			@coded_word[index] = "_"
		end
		getUrl(word)
		setMaxAttempts()
	end

	def tryWith(letter)
		letter = letter.upcase
		unless @letters_list.include?(letter)
			@letters_list.insert(-1,letter)
			auxFailed = @failed_attempts.to_i
			if @secret_word[1,@secret_word.count-2].include?(letter)
				for index in (1 .. @secret_word.count-2)
					@coded_word[index] = letter if @secret_word[index] == letter
				end
				@status_message = "BIEN #{@player_name}! TE FALTA UNA MENOS"
			else
				auxFailed += 1
				@failed_attempts = auxFailed.to_s
				@errors_list.insert(-1,letter)
				@status_message = "TE EQUIVOCASTE #{@player_name}! NO PASA NADA, INTENTA DE NUEVO"
			end
		else
			@status_message = "PRESTA ATENCION! ESA LETRA YA HABIA SIDO INGRESADA"
		end
	end

	def loadWordsListFromFile
		if File.exists?(@words_list_file)		
			wordsListFile = File.new(@words_list_file, "r")
			while (word = wordsListFile.gets)
				word = word[0,word.length-1]
				addWord(word.upcase)
			end
			wordsListFile.close
		end
	end

	def saveWordsListToFile
		begin
			File.delete(@words_list_file) if File.exists?(@words_list_file)
			unless @words_list.empty?
				wordsListFile = File.new(@words_list_file, "a")
				@words_list.sort
				@words_list.each { |auxWordsList| wordsListFile.puts auxWordsList }
				wordsListFile.close
				@status_message = "CAMBIOS GUARDADOS CORRECTAMENTE"
			else
				@status_message = "LA LISTA DE PALABRAS ESTA VACIA"
			end
		rescue IOError
			@status_message = "NO TIENE PERMISO PARA ESCRIBIR EL ARCHIVO"
		end
	end

	def checkWinner
		if @coded_word.eql?(@secret_word)
			@status_message = "FELICITACIONES #{@player_name}! GANASTE!"
			saveGameLog("W")
		end
		return @coded_word.eql?(@secret_word)
	end

	def checkLoser
		if @failed_attempts.to_i >= @max_attempts.to_i
			@status_message = "PERDISTE #{@player_name}! INTENTA DE NUEVO!"
			saveGameLog("L")
		end
		return (@failed_attempts.to_i >= @max_attempts.to_i)
	end

	def getRandomWord
		randomWord = @words_list[rand(@words_list.count)]
		if randomWord != nil
			return randomWord
		else
			@status_message = "NO SE PUEDE JUGAR DIRECTAMENTE YA QUE NO HAY LISTA DE PALABRAS PRECARGADAS"
			return ""
		end
	end

	def getUrl(wordToFind)
		@search_url="http://www.google.com.ar/search?tbm=isch&hl=es&source=hp&biw=1280&bih=681&q=#{wordToFind}&gbv=2&aq=f&aqi=g1&aql=&oq="
	end

	def setMaxAttempts
		case @secret_word.count
		when 1..4
			@max_attempts = "2"
		when 5..6
			@max_attempts = "3"
		when 7
			@max_attempts = "4"
		else
			@max_attempts = "5"
		end
	end

	def guessWord(word)
		word = word.upcase
		@guess_word = "Y - #{word}" 
		@secret_word.to_s == word ? @coded_word.replace(@secret_word) : @failed_attempts = @max_attempts
	end

	def saveGameLog(result)
		begin
			logString = "#{Time.now.asctime}, playerName: #{@player_name}, result: #{result}, secretWord: #{@secret_word.to_s}, failedAttempts: #{@failed_attempts}, errorsList: #{@errors_list.join(",")}, guessWord?: #{@guess_word}"
			gameLogFile = File.new(@game_log_file, "a")
			gameLogFile.puts logString 
			gameLogFile.close
		rescue IOError
			@status_message = "NO TIENE PERMISO PARA ESCRIBIR EL ARCHIVO"
		end
	end

	def setPlayerName(word)
		@player_name = word.upcase
	end

	def setWordsListFilePath(path)
		@words_list_file = "#{path}/wordsList.txt" if path != nil
	end

	def setLogFilePath(path)
		@game_log_file = "#{path}/gameLog.txt" if path != nil
	end

	def showImage
		picture0 = "http://img695.imageshack.us/img695/5093/91851226.jpg"
		picture1 = "http://img217.imageshack.us/img217/2150/97604124.jpg"
		picture2 = "http://img689.imageshack.us/img689/9829/88912957.jpg"
		picture3 = "http://img28.imageshack.us/img28/3644/54314642.jpg"
		picture4 = "http://img263.imageshack.us/img263/6803/60474449.jpg"
		picture5 = "http://img217.imageshack.us/img217/3983/90757365.jpg"
		@picture_to_load = 	case @max_attempts
						when "2"
							case @failed_attempts
							when "0"
								picture0
							when "1"
								picture3
							else
								picture5
							end
						when "3"
							case @failed_attempts
							when "0"
								picture0
							when "1"
								picture1
							when "2"
								picture3
							else
								picture5
							end
						when "4"
							case @failed_attempts
							when "0"
								picture0
							when "1"
								picture1
							when "2"
								picture3
							when "3"
								picture4
							else
								picture5
							end
						else
							case @failed_attempts
							when "0"
								picture0
							when "1"
								picture1
							when "2"
								picture2
							when "3"
								picture3
							when "4"
								picture4
							else
								picture5
							end
						end
		return @picture_to_load
	end
end
