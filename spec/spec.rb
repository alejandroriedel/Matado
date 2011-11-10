require 'lib/game'

describe Matado do

	it "1) Should show 'PERRO,GATO' if 'PERRO' and 'GATO' are added to the list" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		@matado = Matado.new
		@matado.addWord("PERRO")
		@matado.addWord("GATO")
		
		@matado.words_list.should == ["GATO","PERRO"]
	end

	it "2) should set secret word 'PERRO' if I play with 'PERRO'" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.secret_word.should == ["P","E","R","R","O"]
	end

	it "3) Should show 'P _ _ _ O' if I play with the word 'perro'" do
		@matado = Matado.new

		@matado.setSecret("perro")

		@matado.coded_word.should == ["P","_","_","_","O"]
	end

	it "4) Should show 'P E _ _ O' if the secret word is 'PERRO' and I try with 'E'" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("E")

		@matado.coded_word.should == ["P","E","_","_","O"]
	end

	it "5) Should show 'P _ _ _ O' if the secret word is 'PERRO' and I try with 'F'" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("F")

		@matado.coded_word.should == ["P","_","_","_","O"]
	end

	it "6) Should return TRUE if I win the game" do
		@matado = Matado.new
		@matado.setSecret("PERRO")
		@matado.tryWith("E")
		@matado.tryWith("R")

		flag = @matado.checkWinner()

		flag.should == true
	end

	it "7) Should return TRUE if I lose the game" do
		@matado = Matado.new
		@matado.setSecret("PERRO")
		@matado.tryWith("A")
		@matado.tryWith("J")
		@matado.tryWith("K")
		@matado.tryWith("L")
		@matado.tryWith("M")

		flag = @matado.checkLoser()

		flag.should == true
	end

	it "8) Should show 'LETRAS ERRONEAS: F' if the secret word is 'PERRO' and I try with 'F'" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("F")

		@matado.errors_list.should == ["F"]
	end

	it "9) Should show 'LETRAS ERRONEAS: F,J' if the secret word is 'PERRO' and I try with 'F' and I try with 'J'" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("F")
		@matado.tryWith("j")

		@matado.errors_list.should == ["F","J"]
	end

	it "10) Should show 'INTENTOS: 1/10' if a wrong attempt has been made" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("F")

		@matado.failed_attempts.should == "1"
	end

	it "11) Should show 'INTENTOS: 2/10' if a wrong attempt has been made" do
		@matado = Matado.new
		@matado.setSecret("PERRO")

		@matado.tryWith("F")
		@matado.tryWith("J")

		@matado.failed_attempts.should == "2"
	end

	it "12) Should reset the past game metrics if I start the game again" do
		@matado = Matado.new
		@matado.setSecret("PERRO")
		@matado.tryWith("F")
		@matado.tryWith("J")

		@matado.reset()

		@matado.failed_attempts.should == "0"
		@matado.coded_word.should == []
		@matado.secret_word.should == []
		@matado.errors_list.should == []
	end

	it "13) Should load the words list file containing 'PERRO' and 'GATO' and show 'LISTA DE PALABRAS: PERRO,GATO' if I instance the object" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		f = File.new("./public/wordsList.txt", "w")
		f.puts "PERRO"
		f.puts "GATO"
		f.close

		@matado = Matado.new

		@matado.words_list.should == ["GATO","PERRO"]
	end

	it "14) Should delete 'PERRO' from the words list that contains 'PERRO,GATO,CABALLO' if I try to delete 'PERRO'" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		@matado = Matado.new
		@matado.addWord("PERRO")
		@matado.addWord("GATO")
		@matado.addWord("CABALLO")

		@matado.deleteWord("PERRO")

		@matado.words_list.should == ["CABALLO","GATO"]
	end

	it "15) Should delete 'PERRO' from the words list that contains 'PERRO,GATO,CABALLO' if I try to delete 'PERRO'" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		@matado = Matado.new
		@matado.addWord("PERRO")
		@matado.addWord("GATO")
		@matado.addWord("CABALLO")

		@matado.deleteWord("GATO")

		@matado.words_list.should == ["CABALLO","PERRO"]
	end

	it "16) Should save the words list to the file if I save changes" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		f = File.new("./public/wordsList.txt", "w")
		f.puts "PERRO"
		f.close
		@matado = Matado.new
		@matado.addWord("GATO")
		@matado.addWord("CABALLO")

		@matado.saveWordsListToFile()
		@matado.words_list.clear
		@matado.loadWordsListFromFile()

		@matado.words_list.should == ["CABALLO","GATO","PERRO"]
	end

	it "17) Should show 'LISTA DE PALABRAS: ALE' if I add 'ALE', I delete 'ALE' and I add 'ALE'" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		@matado = Matado.new
		@matado.addWord("ALE")
		@matado.deleteWord("ALE")

		@matado.addWord("ALE")

		@matado.words_list.should == ["ALE"]	
	end

	it "18) Should return random words form the list if I ask a random word" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		f = File.new("./public/wordsList.txt", "w")
		f.puts "PERRO"
		f.puts "GATO"
		f.puts "LORO"
		f.puts "ELEFANTE"
		f.puts "CANARIO"
		f.puts "SERPIENTE"
		f.puts "CAMELLO"
		f.puts "RINOCERONTE"
		f.puts "HURON"
		f.close
		@matado = Matado.new

		randomWordToPlay1 = @matado.getRandomWord
		@matado.words_list.include?(randomWordToPlay1).should == true
		randomWordToPlay2 = @matado.getRandomWord
		@matado.words_list.include?(randomWordToPlay2).should == true
		randomWordToPlay3 = @matado.getRandomWord
		@matado.words_list.include?(randomWordToPlay3).should == true
		if ((randomWordToPlay1 == randomWordToPlay2) && (randomWordToPlay1 == randomWordToPlay3))
			areRandom = false
		else
			areRandom = true
		end
		
		areRandom.should == true
	end

	it "19) Should not let me see variables I don't have permission to see, for example @words_list_file" do
		@matado = Matado.new
		flagNoMethodError = false		
		
		begin
			file = @matado.words_list_file
			rescue NoMethodError
				flagNoMethodError = true
		end

		flagNoMethodError.should == true
	end

	it "20) Should modify the max # of attempts depending on the word I'm playing with" do
		@matado = Matado.new

		@matado.setSecret("RINOCERONTE")

		@matado.max_attempts.should == "5"

		@matado.setSecret("GATO")

		@matado.max_attempts.should == "2"

		@matado.setSecret("TIGRE")

		@matado.max_attempts.should == "3"
	end

	it "21) Should set the URL to look for related images when I set a secret word" do
		@matado = Matado.new

		@matado.setSecret("RINOCERONTE")

		@matado.search_url.include?(@matado.secret_word.to_s).should == true
	end

	it "22) Should return a message if the wordsListFile is empty and I try to get a randomWordToPlay" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		@matado = Matado.new

		@matado.getRandomWord.should == ""
		@matado.status_message.should == "NO SE PUEDE JUGAR DIRECTAMENTE YA QUE NO HAY LISTA DE PALABRAS PRECARGADAS"
	end

	it "23) Should log the played games within a log file" do
		File.delete("./public/gameLog.txt") if File.exists?("./public/gameLog.txt")
		@matado = Matado.new
		@matado.setPlayerName("ALEJANDRO")	
		@matado.setSecret("PERRO")
		@matado.tryWith("E")
		@matado.tryWith("R")

		@matado.checkWinner().should == true

		File.exists?("./public/gameLog.txt").should == true
		f = File.new("./public/gameLog.txt", "r")
		logLine = f.gets
		logLine[26,logLine.length].should == "playerName: ALEJANDRO, result: W, secretWord: PERRO, failedAttempts: 0, errorsList: , guessWord?: N\n"

		#--------------------------

		File.delete("./public/gameLog.txt")
		@matado = Matado.new
		@matado.setPlayerName("ALEJANDRO")	
		@matado.setSecret("PERRO")
		@matado.guessWord("PERRO")

		@matado.checkWinner().should == true

		File.exists?("./public/gameLog.txt").should == true
		f = File.new("./public/gameLog.txt", "r")
		logLine = f.gets
		logLine[26,logLine.length].should == "playerName: ALEJANDRO, result: W, secretWord: PERRO, failedAttempts: 0, errorsList: , guessWord?: Y - PERRO\n"
	end

	it "24) Should log the played games within a log file" do
		File.delete("./public/gameLog.txt") if File.exists?("./public/gameLog.txt")
		@matado = Matado.new
		@matado.setPlayerName("ALEJANDRO")	
		@matado.setSecret("PERRO")
		@matado.tryWith("A")
		@matado.tryWith("S")
		@matado.tryWith("L")

		@matado.checkLoser().should == true

		File.exists?("./public/gameLog.txt").should == true
		f = File.new("./public/gameLog.txt", "r")
		logLine = f.gets
		logLine[26,logLine.length].should == "playerName: ALEJANDRO, result: L, secretWord: PERRO, failedAttempts: 3, errorsList: A,S,L, guessWord?: N\n"

		#--------------------------

		File.delete("./public/gameLog.txt")
		@matado = Matado.new	
		@matado.setPlayerName("ALEJANDRO")	
		@matado.setSecret("PERRO")
		@matado.guessWord("GATO")

		@matado.checkLoser().should == true

		File.exists?("./public/gameLog.txt").should == true
		f = File.new("./public/gameLog.txt", "r")
		logLine = f.gets
		logLine[26,logLine.length].should == "playerName: ALEJANDRO, result: L, secretWord: PERRO, failedAttempts: 3, errorsList: , guessWord?: Y - GATO\n"
	end

	it "25) Should show an image relative to the status of the attempts" do
		@matado = Matado.new
		@matado.setSecret("ESCOLAPIO")

		@matado.showImage().include?("imageshack").should == true

		@matado.tryWith("U")
		@matado.showImage().include?("imageshack").should == true

		@matado.tryWith("X")
		@matado.showImage().include?("imageshack").should == true

		@matado.tryWith("Y")
		@matado.showImage().include?("imageshack").should == true

		@matado.tryWith("Z")
		@matado.showImage().include?("imageshack").should == true

		@matado.tryWith("J")
		@matado.showImage().include?("imageshack").should == true
	end

	it "26) Should rescue file erros" do
		begin
			f = File.new("./public/gameLog.txt", "r")
			f.puts "Test string"
		rescue IOError
			statusMessage = "NO TIENE PERMISO PARA ESCRIBIR EL ARCHIVO"
		end
		f.close

		statusMessage.should == "NO TIENE PERMISO PARA ESCRIBIR EL ARCHIVO"
	end

	#NO MOVER ESTE TEST YA QUE ES NECESARIO PARA DEJAR EL AMBIENTE FUNCIONANDO
	it "*) Should delete the files after all tests are run" do
		File.delete("./public/wordsList.txt") if File.exists?("./public/wordsList.txt")
		File.delete("./public/gameLog.txt") if File.exists?("./public/gameLog.txt")
	end

end
