Feature: administrador configura juego

	- Como administrador
	  quiero recibir un mensaje de bienvenida
	  para saber que estoy en condiciones de configurar el juego
	- Como administrador
	  quiero configurar una lista de palabras
	  para que puedan ser seleccionadas aleatoriamente en el juego.
	- Como administrador
	  quiero asociar una imagen a cada palabra ingresada
	  para que sirvan como guía al jugador
	- Como administrador
	  quiero poder confirmar los cambios
	  para que se guarden mis modificaciones
	- Comom administrador
	  quiero poder ingresar una palabra determinada
	  para poder jugar con ella
	
	Scenario: Mensajes iniciales de configuracion
		Given I am in config game mode
		Then I should see "MODO DE CONFIGURACION"
		And I should see "INGRESE UNA PALABRA PARA JUGAR"
		And I should see "INGRESE UNA PALABRA PARA AGREGAR A LA LISTA"
		And I should see "INGRESE UNA PALABRA PARA BORRAR DE LA LISTA"
		And I should see "LISTA DE PALABRAS:"
		And I should see "IMPORTANTE: SI EXISTE UNA IMAGEN QUE COINCIDA CON EL NOMBRE DE LA PALABRA SE CARGARA DURANTE EL JUEGO. EJ: PARA 'PERRO' LA IMAGEN SE DEBERA LLAMAR 'PERRO.JPG'"

	Scenario: Agregar "GATO" y "CABALLO"
		Given I am in config game mode
		#And The words list file is empty or it doesn't exist
		When I enter "GATO" into "wordToAdd"
		And I press "AGREGAR"
		And I enter "caballo" into "wordToAdd"
		And I press "AGREGAR"
		Then I should see "LISTA DE PALABRAS: GATO,CABALLO"
		And I should see "PALABRA AGREGADA CORRECTAMENTE"

	Scenario: Agregar "GATO" en forma duplicada
		Given I am in config game mode
		When I enter "GATO" into "wordToAdd"
		And I press "AGREGAR"
		And I enter "GATO" into "wordToAdd"
		And I press "AGREGAR"
		Then I should see "LISTA DE PALABRAS: GATO"
		And I should see "LA PALABRA YA EXISTE EN LA LISTA"

	Scenario: Eliminar "PERRO"
		Given I am in config game mode
		When I enter "PERRO" into "wordToAdd"
		And I press "AGREGAR"
		And I enter "GATO" into "wordToAdd"
		And I press "AGREGAR"
		And I enter "CABALLO" into "wordToAdd"
		And I press "AGREGAR"
		When I enter "PERrO" into "wordToDelete"
		And I press "BORRAR"
		Then I should see "LISTA DE PALABRAS: GATO,CABALLO"
		And I should see "PALABRA BORRADA CORRECTAMENTE"

	Scenario: Eliminar palabra que no existe en la lista
		Given I am in config game mode
		When I enter "GATO" into "wordToAdd"
		And I press "AGREGAR"
		And I enter "PERrO" into "wordToDelete"
		And I press "BORRAR"
		Then I should see "LISTA DE PALABRAS: GATO"
		And I should see "LA PALABRA NO SE ENCUENTRA EN LA LISTA"

	Scenario: Guardar lista de palabras vacía en archivo
		Given I am in config game mode
		And I press "GUARDAR CAMBIOS"
		Then I should see "LA LISTA DE PALABRAS ESTA VACIA"

	Scenario: Guardar lista de palabras en archivo
		Given I am in config game mode
		When I enter "PERRO" into "wordToAdd"
		And I press "AGREGAR"
		And I press "GUARDAR CAMBIOS"
		Then I should see "CAMBIOS GUARDADOS CORRECTAMENTE"

	Scenario: Jugar con palabra determinada
		Given I am in config game mode
		When I enter "pERRO" into "wordToPlay"
		And I press "JUGAR"
		Then I should see "P _ _ _ O"
