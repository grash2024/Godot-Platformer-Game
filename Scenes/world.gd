extends Node2D

var pause=true
func _on_button_pressed():
	get_tree().paused= pause
	pause=not pause
