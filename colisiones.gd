extends Node3D

func _ready():
	# Añadir colisiones automáticamente a todas las calles
	agregar_colisiones_a_grupo($Calles)
	# Añadir colisiones automáticamente a todos los edificios
	agregar_colisiones_a_grupo($Edificios)

func agregar_colisiones_a_grupo(grupo_nodo):
	for child in grupo_nodo.get_children():
		# Solo aplicar a MeshInstance3D
		if child is MeshInstance3D:
			# Crear StaticBody3D
			var static_body = StaticBody3D.new()
			child.add_child(static_body)

			# Crear CollisionShape3D
			var collision_shape = CollisionShape3D.new()
			var box_shape = BoxShape3D.new()

			# Ajustar el tamaño del BoxShape para coincidir con el tamaño del Mesh
			var mesh_aabb = child.get_mesh().get_aabb()
			box_shape.extents = mesh_aabb.size * 0.5  # Mitad del tamaño del Mesh
			collision_shape.shape = box_shape

			static_body.add_child(collision_shape)
			static_body.owner = child.owner  # Hacerlo parte de la escena para guardar
			collision_shape.owner = child.owner
