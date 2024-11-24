extends Node3D

# Altura y rotación objetivo
var altura_objetivo: float = 0.0
var rotacion_x_objetivo: float = 0.0

func _ready():
	print("Iniciando alineación de nodos (dinámico)...")
	alinear_todos_los_nodos(self)

func alinear_todos_los_nodos(grupo_nodo):
	for child in grupo_nodo.get_children():
		# Verifica si el nodo tiene 'translation' y 'rotation'
		if child.has_method("set_translation") and child.has_method("set_rotation"):
			# Ajustar posición en Y
			var posicion_actual = child.translation
			posicion_actual.y = altura_objetivo
			child.translation = posicion_actual

			# Ajustar rotación en X
			var rotacion_actual = child.rotation_degrees
			rotacion_actual.x = rotacion_x_objetivo
			child.rotation_degrees = rotacion_actual

			print("Alineado:", child.name, 
				  "a Y =", altura_objetivo, 
				  "y Rotación X =", rotacion_x_objetivo)

		# Procesar recursivamente los hijos del nodo actual
		if child.get_child_count() > 0:
			alinear_todos_los_nodos(child)

	# Finalmente, ajustar al nodo padre (grupo_nodo)
	if grupo_nodo.has_method("set_translation") and grupo_nodo.has_method("set_rotation"):
		var posicion_actual = grupo_nodo.translation
		posicion_actual.y = altura_objetivo
		grupo_nodo.translation = posicion_actual

		var rotacion_actual = grupo_nodo.rotation_degrees
		rotacion_actual.x = rotacion_x_objetivo
		grupo_nodo.rotation_degrees = rotacion_actual

		print("Alineado nodo padre:", grupo_nodo.name, 
			  "a Y =", altura_objetivo, 
			  "y Rotación X =", rotacion_x_objetivo)
