Feature: usuario inicia juego

	- Como usuario
	  quiero ver un mensaje de bienvenida
	  para saber que estoy dentro del juego
	- Como usuario
	  quiero tener la posibilidad de ir al menú de configuración
	  para para poder configurar el juego.
	- Como usuario
	  quiero tener la posibilidad de ir al juego
	  para comenzar a jugar
	
	Scenario: Mensaje de Bienvenida
		Given I open the game
		Then I should see "BIENVENIDO AL MATADO"
		And I should see "NOTA: SI DESEA JUGAR SIN IR A LA CONFIGURACION, SE ELEGIRA UNA PALABRA AL AZAR DE LAS DISPONIBLES"
		And I should see "ESTE JUEGO ES SIMILAR A UN AHORCADO, PERO EN VEZ DE ADIVINAR UNO DEBE COMPLETAR LAS PALABRAS QUE SE MUESTRAN EN LA FIGURA. LO DESARROLLE CUANDO MI HIJA MAYOR COMENZO LA PRIMARIA, PARA AYUDARLA A APRENDER A ESCRIBIR. POR ESO, EL OBJETIVO DEL JUEGO NO ES ADIVINAR SINO TRATAR DE COMPLETAR LOS ESPACIOS EN BASE A UNA PALABRA CONOCIDA."
		And I should see "EL JUEGO LE DEBE SU NOMBRE A UNO DE ESOS ERRORES TAN LINDOS QUE COMETEN LOS CHICOS CUANDO COMIENZAN A HABLAR"

	Scenario: Ir al menú de configuración
		Given I open the game
		When I press "CONFIGURAR"
		Then I should see "MODO DE CONFIGURACION"

	Scenario: Comenzar a jugar
		Given I open the game
		#And The wordsListFile is not empty
		When I press "JUGAR"
		Then I should see "BIENVENIDA LUNA"
