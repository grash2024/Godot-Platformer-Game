extends TileMap
func _on_main_gate_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file.bind("res://Scenes/sub_world.tscn").call_deferred()
