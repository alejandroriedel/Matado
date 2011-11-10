Feature: jugador inicia juego

	- Como jugador
	  quiero ver un mensaje de bienvenida
	  para saber que estoy jugando.
	- Como jugador
	  quiero ver la letra inicial y final de la palabra que tengo que adivinar
	  para tener un marco de referencia (ya testeado en feature 2)
	- Como jugador
	  quiero ver la imágen relacionada con la palabra que tengo que adivinar
	  para poder guiarme e intuir las letras en vez de adivinarlas
	- Como jugador
	  quiero poder ingresar letras
	  para completar la palabra secreta
	- Como jugador
	  quiero ver el avance incluyendo las letras acertadas
	  para saber cuál es mi progreso
	- Como jugador
	  quiero ver una lista de las letras erroneas
	  para no volver a ingresarlas
	
	Scenario: Mensajes iniciales
		Given I start playing
		Then I should see "BIENVENIDA LUNA"
		And I should see "INGRESE UNA LETRA"
		And I should see "LETRAS ERRONEAS:"
		And I should see "INTENTOS: 0/"

	Scenario: Imagen inicial "PERRO"
		Given The secret word is "PERRO" & I start playing
		Then I should see an image related

	Scenario: Ingresar letra correcta "E"
		Given The secret word is "PERRO" & I start playing
		When I enter "E" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "P E _ _ O"
		And I should see "BIEN BORREGA! TE FALTA UNA MENOS"

	Scenario: Ingresar 2 letras correctas
		Given The secret word is "PERROS" & I start playing
		When I enter "E" into "letterAttempt"
		And I press "INTENTAR"
		And I enter "O" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "P E _ _ O S"
		And I should see "BIEN BORREGA! TE FALTA UNA MENOS"

	Scenario: Ingresar letra erronea "F"
		Given The secret word is "PERRO" & I start playing
		When I enter "F" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "P _ _ _ O"
		And I should see "LETRAS ERRONEAS: F"
		And I should see "INTENTOS: 1/3"
		And I should see "TE EQUIVOCASTE ENANA! NO PASA NADA, INTENTA DE NUEVO"

	Scenario: Ingresar 2 letras erronea
		Given The secret word is "PERRO" & I start playing
		When I enter "J" into "letterAttempt"
		And I press "INTENTAR"
		And I enter "f" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "P _ _ _ O"
		And I should see "LETRAS ERRONEAS: J,F"
		And I should see "INTENTOS: 2/3"
		And I should see "TE EQUIVOCASTE ENANA! NO PASA NADA, INTENTA DE NUEVO"
	
	Scenario: Ingresar letra correcta duplicada
		Given The secret word is "PERROS" & I start playing
		When I enter "E" into "letterAttempt"
		And I press "INTENTAR"
		And I enter "E" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "PRESTA ATENCION! ESA LETRA YA HABIA SIDO INGRESADA"

	Scenario: Ingresar letra incorrecta duplicada
		Given The secret word is "PERROS" & I start playing
		When I enter "J" into "letterAttempt"
		And I press "INTENTAR"
		And I enter "J" into "letterAttempt"
		And I press "INTENTAR"
		Then I should see "PRESTA ATENCION! ESA LETRA YA HABIA SIDO INGRESADA"

	Scenario: Salir de la aplicación durante el juego
		Given The secret word is "PERROS" & I start playing
		When I press "SALIR DEL JUEGO"
		Then I should see "CHAU BORREGUITA!"
