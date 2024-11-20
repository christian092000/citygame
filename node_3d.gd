extends Node3D

func _ready():
	var estructuras = $estructuras

	if estructuras == null:
		print("El nodo 'Estructuras' no existe.")
		return

	# Recorre todas las estructuras (calles, edificios, parques, etc.)
	agregar_colisiones_a_grupo(estructuras)

func agregar_colisiones_a_grupo(grupo_nodo):
	for child in grupo_nodo.get_children():
		# Verifica si el nodo es un MeshInstance3D (relevante para colisiones)
		if child is MeshInstance3D:
			# Añadir colisión automáticamente
			var static_body = StaticBody3D.new()
			child.add_child(static_body)

			var collision_shape = CollisionShape3D.new()
			var box_shape = BoxShape3D.new()

			# Ajustar el tamaño del BoxShape al tamaño del Mesh
			var mesh_aabb = child.get_mesh().get_aabb()
			box_shape.extents = mesh_aabb.size * 0.5  # Mitad del tamaño del Mesh
			collision_shape.shape = box_shape
				
			static_body.add_child(collision_shape)

			# Establecer la propiedad "owner" para que se guarde correctamente
			static_body.owner = child.owner
			collision_shape.owner = child.owner
			#print("Hello world")
			#print(child.name)
			#print(child.owner.name)

		elif child is Node3D:
			# Si hay subgrupos (por ejemplo, calles agrupadas), recorrerlos también
			agregar_colisiones_a_grupo(child)
