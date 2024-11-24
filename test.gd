extends Node3D  # Ajusta el tipo según tu nodo principal

func _ready():
	# Busca los nodos de 'player' y 'carros' en la escena padre
	var player = $Character  # Ajusta la ruta al nodo del jugador
	var carros = $Carros  # Ajusta la ruta al nodo 'carros'

	# Asigna el nodo del jugador al script de 'carros'
	if carros and carros.has_script():
		carros.set("player", player)
