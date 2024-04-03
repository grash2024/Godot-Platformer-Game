extends TileMap

func _on_door_area_body_entered(body):
	if body is Player:
		Globals.position_state=3
		get_tree().change_scene_to_file.bind("res://Scenes/world.tscn").call_deferred()
		
#player position must be chaged near gate position
