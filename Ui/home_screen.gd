extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file.bind("res://Scenes/world.tscn").call_deferred()

func _on_exit_button_pressed():
	get_tree().quit()
