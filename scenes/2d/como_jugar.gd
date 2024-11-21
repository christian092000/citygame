extends Button


func _on_pressed() -> void:
	var scene = load("res://scenes/2d/como_jugar.tscn")
	get_tree().change_scene_to_packed(scene)
