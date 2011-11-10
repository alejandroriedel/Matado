Feature: jugador termina juego

	- Como jugador
	  quiero ver una pantalla de ganador
	  para saber que gané el juego
	- Como jugador
	  quiero tener la posibilidad de comenzar juego nuevo
	  para poder volver a jugar
	- Como jugador
	  quiero tener la posibilidad de terminar el juego
	  para cerrar el ahorcado y salir
	
	Scenario: Ganador "PERRO"
		Given I win the game playing with "PERRO"
		Then I should see "FELICITACIONES LUNA! GANASTE!" 
		And I should see "LA PALABRA SECRETA ERA: PERRO"

	Scenario: Perdedor "PERRO"
		Given I lose the game playing with "PERRO"
		Then I should see "PERDISTE BORREGA! INTENTA DE NUEVO!" 
		And I should see "LA PALABRA SECRETA ERA: PERRO"

	Scenario: Volver al inicio
		Given I win the game playing with "PERRO"
		When I press "VOLVER AL INICIO"
		Then I should see "BIENVENIDO AL MATADO"

	Scenario: Volver a jugar después de ganar
		Given I win the game playing with "PERRO"
		When I press "JUGAR NUEVAMENTE"
		Then I should see "BIENVENIDA LUNA"
		And I should see "LETRAS ERRONEAS:"

	Scenario: Volver a jugar después de perder
		Given I lose the game playing with "PERRO"
		When I press "JUGAR NUEVAMENTE"
		Then I should see "BIENVENIDA LUNA"
		And I should see "LETRAS ERRONEAS:"

	Scenario: Salir del juego
		Given I win the game playing with "PERRO"
		When I press "SALIR DEL JUEGO"
		Then I should see "CHAU BORREGUITA!"
