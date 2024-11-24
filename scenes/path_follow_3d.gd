extends PathFollow3D

@export var speed: float = 10.0  # Velocidad del carro

func _process(delta: float) -> void:
	# Mover el carro a lo largo del trayecto
	progress_ratio += speed * delta / get_parent().curve.get_baked_length()
	# Hacer que el movimiento sea cíclico
	progress_ratio = fmod(progress_ratio, 1.0)
