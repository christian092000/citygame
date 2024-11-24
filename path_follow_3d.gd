extends PathFollow3D

@export var speed: float = 4.0  # Velocidad del carro

func _process(delta: float) -> void:
	# Asegurarse de que el nodo padre es un Path3D con una curva válida
	if get_parent() and get_parent() is Path3D:
		# Incrementar el progreso del carro en el trayecto
		progress_ratio += speed * delta / get_parent().curve.get_baked_length()
		# Asegurar que el movimiento sea cíclico
		progress_ratio = fmod(progress_ratio, 1.0)
