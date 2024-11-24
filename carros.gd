extends Node3D

@export var player: Node3D  # Jugador, asegúrate de configurarlo correctamente
@export var detection_radius: float = 2.0  # Radio de detección en metros

func _ready():
	# Asignar el nodo jugador automáticamente si está en la misma escena
	if not player:
		player = $Player  # Cambia "Player" por el nombre real del nodo del jugador

func _process(delta: float) -> void:
	# Validar que el jugador esté configurado y sea un Node3D
	if not player or not player is Node3D:
		print("Error: El nodo jugador no está configurado o no es un Node3D.")
		return

	# Iteramos sobre todas las calles
	for calle in get_children():
		if calle is Node3D:  # Aseguramos que sea un nodo válido
			# Iteramos sobre los Path3D dentro de cada calle
			for path in calle.get_children():
				if path is Path3D:  # Verificamos que sea un Path3D
					# Iteramos sobre los PathFollow3D (carros) dentro del Path3D
					for path_follow in path.get_children():
						if path_follow is PathFollow3D:
							# Obtener la posición del carro
							var car_position = path_follow.global_transform.origin
							# Obtener la posición del jugador
							var player_position = player.global_transform.origin
							# Calcular la distancia entre el jugador y el carro
							var distance = car_position.distance_to(player_position)
							
							# Si la distancia está dentro del radio de detección
							if distance <= detection_radius:
								print("¡El jugador ha sido tocado por un carro en", calle.name, "!")
								handle_player_touched()
								return  # Salimos para evitar múltiples detecciones en un solo frame

func handle_player_touched() -> void:
	# Lógica cuando el jugador es tocado por un carro
	print("Reiniciando nivel...")
	get_tree().reload_current_scene()  # Reinicia la escena actual
