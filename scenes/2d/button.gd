extends Button

func _on_pressed():
	# Cambia a la escena 3D
	var scene = load("res://scenes/test.tscn")
	get_tree().change_scene_to_packed(scene)
